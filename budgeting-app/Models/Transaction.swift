//
//  Transaction.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Foundation
import SwiftUICore

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

extension TransactionCategory {
    var color: Color {
        switch self {
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
