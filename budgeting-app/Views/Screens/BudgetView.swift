//
//  BudgetView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 2.11.24.
//

import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var budgetManager: BudgetManager
    @EnvironmentObject var transactionManager: TransactionManager
    @EnvironmentObject var currencyManager: CurrencyManager
    
    @State private var showingResetAlert = false
    @State private var showingBudgetSheet = false
    @State private var newBudgetAmount: String = ""
    @State private var selectedPeriod: Period = .monthly
    @State private var startDate = Date()
    
    private var currentSpending: Double {
        guard let budget = budgetManager.currentBudget else { return 0 }
        
        let calendar = Calendar.current
        let now = Date()
        
        switch budget.period {
        case .monthly:
            let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            return transactionManager.getExpensesForDateRange(from: startOfMonth, to: now)
        case .weekly:
            let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            return transactionManager.getExpensesForDateRange(from: startOfWeek, to: now)
        case .yearly:
            let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
            return transactionManager.getExpensesForDateRange(from: startOfYear, to: now)
        }
    }
    
    private var remainingBudget: Double {
        guard let budget = budgetManager.currentBudget else { return 0 }
        return budget.amount - currentSpending
    }
    
    private var progressPercentage: Double {
        guard let budget = budgetManager.currentBudget, budget.amount > 0 else { return 0 }
        return min(currentSpending / budget.amount, 1.0)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let budget = budgetManager.currentBudget {
                        VStack(spacing: 16) {
                            Text("\(budget.period.rawValue.capitalized) Budget")
                                .font(.headline)
                            
                            Text(currencyManager.formatCurrency(budget.amount, addSigns: false))
                                .font(.system(size: 34, weight: .bold))
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 20)
                                        .cornerRadius(10)
                                    
                                    Rectangle()
                                        .fill(progressPercentage >= 1.0 ? Color.red : Color.blue)
                                        .frame(width: geometry.size.width * progressPercentage, height: 20)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(height: 20)
                            .padding(.vertical)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Spent")
                                        .foregroundColor(.gray)
                                    Text(currencyManager.formatCurrency(currentSpending, addSigns: false))
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Remaining")
                                        .foregroundColor(.gray)
                                    Text(currencyManager.formatCurrency(remainingBudget, addSigns: remainingBudget < 0 ? true : false))
                                        .font(.headline)
                                        .foregroundColor(remainingBudget >= 0 ? .green : .red)
                                }
                            }
                            Button(action: {
                                showingResetAlert = true
                            }) {
                                Text("Reset Budget")
                                    .foregroundColor(.red)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                            }
                            .padding(.top, 8)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "banknote")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("No Budget Set")
                                .font(.headline)
                            
                            Text("Set a budget to track your spending")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Budget")
            .toolbar {
                Button(action: {
                    showingBudgetSheet = true
                }) {
                    Image(systemName: budgetManager.currentBudget == nil ? "plus" : "pencil")
                }
            }
            .sheet(isPresented: $showingBudgetSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Budget Details")) {
                            TextField("Amount", text: $newBudgetAmount)
                                .keyboardType(.decimalPad)
                            
                            Picker("Period", selection: $selectedPeriod) {
                                Text("Monthly").tag(Period.monthly)
                                Text("Weekly").tag(Period.weekly)
                                Text("Yearly").tag(Period.yearly)
                            }
                            
                            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        }
                    }
                    .navigationTitle(budgetManager.currentBudget == nil ? "Set Budget" : "Edit Budget")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingBudgetSheet = false
                        },
                        trailing: Button("Save") {
                            if let amount = Double(newBudgetAmount) {
                                budgetManager.setBudget(amount: amount, period: selectedPeriod, startDate: startDate)
                                showingBudgetSheet = false
                            }
                        }
                        .disabled(Double(newBudgetAmount) == nil)
                    )
                }
            }
        }
        .alert("Reset Budget", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                budgetManager.resetBudget()
            }
        } message: {
            Text("Are you sure you want to reset your budget? This action cannot be undone.")
        }
        .onAppear {
            budgetManager.loadBudget()
            if let currentBudget = budgetManager.currentBudget {
                newBudgetAmount = String(format: "%.2f", currentBudget.amount)
                selectedPeriod = currentBudget.period
                startDate = currentBudget.startDate
            }
        }
    }
}
