//
//  TransactionRow.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore


struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: iconForCategory(transaction.category))
                .foregroundColor(colorForCategory(transaction.category))
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(colorForCategory(transaction.category).opacity(0.2))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                Text(transaction.date, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(String(format: "$%.2f", transaction.amount))
                .font(.headline)
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
        .padding(.vertical, 8)
    }
    
    private func iconForCategory(_ category: TransactionCategory) -> String {
        switch category {
        case .food: return "fork.knife"
        case .transport: return "car.fill"
        case .shopping: return "cart.fill"
        case .bills: return "doc.text.fill"
        case .entertainment: return "tv.fill"
        case .health: return "heart.fill"
        case .other: return "square.grid.2x2.fill"
        }
    }
    
    private func colorForCategory(_ category: TransactionCategory) -> Color {
        switch category {
        case .food: return .blue
        case .transport: return .green
        case .shopping: return .purple
        case .bills: return .red
        case .entertainment: return .orange
        case .health: return .pink
        case .other: return .gray
        }
    }
}

// Color and Icon helpers that can be used across views
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
        case .entertainment: return "tv.fill"
        case .health: return "heart.fill"
        case .other: return "square.grid.2x2.fill"
        }
    }
}

