
//  TransactionViewModel.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(amount: Double, category: TransactionCategory, isIncome: Bool) {
        let currentDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: Date())) ?? Date()

        let transaction = Transaction(
            amount: amount,
            category: category,
            date: currentDate,
            isIncome: isIncome
        )
        transactions.append(transaction)

        objectWillChange.send()
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
        
        var expensesByCategory: [TransactionCategory: Double] = [:]
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
