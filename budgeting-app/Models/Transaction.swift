//
//  Transaction.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Foundation

enum TransactionCategory: String, CaseIterable, Comparable {
    case food = "Food"
    case transport = "Transport"
    case shopping = "Shopping"
    case bills = "Bills"
    case entertainment = "Entertainment"
    case health = "Health"
    case other = "Other"
    
    static func < (lhs: TransactionCategory, rhs: TransactionCategory) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
struct Transaction: Identifiable {
    let id = UUID()
    var amount: Double
    var category: TransactionCategory
    var date: Date
    var isIncome: Bool
}
