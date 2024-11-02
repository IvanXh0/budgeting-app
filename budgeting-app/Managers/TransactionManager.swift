//
//  TransactionManager.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 2.11.24.
//

import Foundation

class TransactionManager: ObservableObject {
    @Published var transactions: [Transaction] = [] {
        didSet {
            saveTransactions()
        }
    }
    
    init() {
        loadTransactions()
    }

    func addTransaction(amount: Double, category: CategoryItem, isIncome: Bool) {
        let currentDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date())) ?? Date()

        let transaction = Transaction(
            amount: amount,
            category: category,
            date: currentDate,
            isIncome: isIncome
        )
        transactions.append(transaction)
    }

    func deleteTransaction(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
    }

    func deleteTransactions(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
    
    func deleteAllTransactions() {
        transactions.removeAll()
    }
    
    private func saveTransactions() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(transactions)
            UserDefaults.standard.set(data, forKey: "transactions")
        } catch {
            print("Error saving transactions: \(error)")
        }
    }
    
    private func loadTransactions() {
        if let data = UserDefaults.standard.data(forKey: "transactions") {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                transactions = try decoder.decode([Transaction].self, from: data)
            } catch {
                print("Error loading transactions: \(error)")
                transactions = []
            }
        }
    }
    
    func monthlySummary(for date: Date = Date()) -> MonthlySummary {
        let start = date.startOfMonth
        let end = date.endOfMonth
        
        let monthTransactions = transactions.filter { transaction in
            let isInRange = transaction.date >= start && transaction.date <= end
            return isInRange
        }
        
        let income = monthTransactions.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
        let expenses = monthTransactions.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
        
        var expensesByCategory: [CategoryItem: Double] = [:]
        monthTransactions.filter { !$0.isIncome }.forEach { transaction in
            expensesByCategory[transaction.category, default: 0] += transaction.amount
        }
        
        return MonthlySummary(
            income: income,
            expenses: expenses,
            balance: income - expenses,
            expensesByCategory: expensesByCategory
        )
    }
    
    func dailyTransactions(for date: Date = Date()) -> [Transaction] {
        transactions.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }.sorted { $0.date > $1.date }
    }
}
