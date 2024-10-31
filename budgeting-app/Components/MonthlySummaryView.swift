//
//  MonthlySummaryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import Charts
import UIKit


import Charts

struct MonthlySummaryView: View {
    let summary: MonthlySummary

    var body: some View {
        VStack(spacing: 16) {
            // Summary Cards
            HStack(spacing: 12) {
                Spacer()
                SummaryCard(title: "Income", amount: summary.income, color: .green)
                SummaryCard(title: "Expenses", amount: summary.expenses, color: .red)
                SummaryCard(title: "Balance", amount: summary.balance, color: summary.balance >= 0 ? .blue : .red)
                Spacer()
            }

            // Category Breakdown using Charts
            VStack(spacing: 8) {
                Text("Expenses by Category")
                    .font(.headline)
                    .padding(.top)

                Chart {
                    ForEach(Array(summary.expensesByCategory.keys), id: \.self) { category in
                        if let amount = summary.expensesByCategory[category] {
                            BarMark(
                                x: .value("Category", category.rawValue),
                                y: .value("Amount", amount)
                            )
                            .foregroundStyle(category.color)
                        }
                    }
                }
                .frame(height: 200)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 2))
        }
        .padding()
    }
}
