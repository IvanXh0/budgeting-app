//
//  Transaction.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Foundation
import SwiftUICore

enum TransactionCategory: String, CaseIterable, Comparable {
    // income categories
    case salary = "Salary"
    case gift = "Gift"
    case investment = "Investment"

    // expense categories
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

    static var incomeCategories: [TransactionCategory] {
        [.salary, .gift, .investment]
    }

    static var expenseCategories: [TransactionCategory] {
        [.food, .transport, .shopping, .bills, .entertainment, .health, .other]
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    var amount: Double
    var category: TransactionCategory
    var date: Date
    var isIncome: Bool
}

extension TransactionCategory {
    var color: Color {
        switch self {
        case .salary: return .green
        case .investment: return .purple
        case .gift: return .pink
        case .food: return .blue
        case .transport: return .green
        case .shopping: return .purple
        case .bills: return .red
        case .entertainment: return .orange
        case .health: return .pink
        case .other: return .gray
        }
    }

    var icon: String {
        switch self {
        case .salary: return "dollarsign.circle.fill"
        case .investment: return "chart.line.uptrend.xyaxis"
        case .gift: return "gift.fill"
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .shopping: return "cart.fill"
        case .bills: return "doc.text.fill"
        case .entertainment: return "gamecontroller.fill"
        case .health: return "heart.fill"
        case .other: return "questionmark.circle.fill"
        }
    }
}
