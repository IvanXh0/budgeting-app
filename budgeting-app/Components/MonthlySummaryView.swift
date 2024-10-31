//
//  MonthlySummaryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import Charts
import UIKit


struct MonthlySummaryView: View {
    let summary: MonthlySummary
    
    var body: some View {
        VStack(spacing: 16) {
            // Summary Cards
            Text("Debug - Income: \(summary.income)")
                .font(.caption)
            Text("Debug - Expenses: \(summary.expenses)")
                .font(.caption)
            HStack(spacing: 20) {
                SummaryCard(title: "Income", amount: summary.income, color: .green)
                SummaryCard(title: "Expenses", amount: summary.expenses, color: .red)
                SummaryCard(title: "Balance", amount: summary.balance, color: summary.balance >= 0 ? .blue : .red)
            }
            
            // Category Breakdown
            VStack(spacing: 8) {
                Text("Expenses by Category")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(Array(summary.expensesByCategory.keys.sorted()), id: \.self) { category in
                    if let amount = summary.expensesByCategory[category] {
                        HStack {
                            Image(systemName: iconForCategory(category))
                                .foregroundColor(colorForCategory(category))
                            
                            Text(category.rawValue)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            // Progress bar
                            GeometryReader { geometry in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(colorForCategory(category))
                                    .frame(width: progressWidth(for: amount, in: summary.expenses, totalWidth: geometry.size.width))
                            }
                            .frame(height: 8)
                            .frame(width: 100)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(4)
                            
                            Text(String(format: "$%.2f", amount))
                                .foregroundColor(.secondary)
                                .frame(width: 80, alignment: .trailing)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 2))
        }
        .padding()
    }
    
    private func progressWidth(for amount: Double, in total: Double, totalWidth: CGFloat) -> CGFloat {
        let percentage = total > 0 ? amount / total : 0
        return CGFloat(percentage) * totalWidth
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
}
