//
//  MonthlySummaryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI
import Charts

import SwiftUI
import Charts

struct MonthlySummaryView: View {
    let summary: MonthlySummary

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 16) {
                SummaryCard(income: summary.income, expenses: summary.expenses, balance: summary.balance)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 16) {
                Text("Expenses by Category")
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)

                if summary.expensesByCategory.isEmpty {
                    Text("No expenses this month")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Chart {
                        ForEach(summary.expensesByCategory.sorted(by: { $0.value > $1.value }), id: \.key) { category, amount in
                            SectorMark(
                                angle: .value("Amount", amount),
                                innerRadius: .ratio(0.5),
                                angularInset: 1.0
                            )
                            .foregroundStyle(category.color)
                            .annotation(position: .overlay) {
                                VStack(spacing: 2) {
                                    Text(category.rawValue)
                                        .font(.caption2)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                }
                                .padding(4)
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(4)
                            }
                        }
                    }
                    .frame(height: 300)
                    .padding(.horizontal)
                    .chartLegend(position: .bottom) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(summary.expensesByCategory.keys.sorted(), id: \.self) { category in
                                    HStack(spacing: 8) {
                                        Circle()
                                            .fill(category.color)
                                            .frame(width: 14, height: 14)
                                        Text(category.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
