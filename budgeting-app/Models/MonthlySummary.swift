//
//  MonthlySummary.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//


struct MonthlySummary {
    var income: Double
    var expenses: Double
    var balance: Double
    var expensesByCategory: [TransactionCategory: Double]
}
