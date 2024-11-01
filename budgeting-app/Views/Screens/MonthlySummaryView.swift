//
//  MonthlySummaryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Charts
import SwiftUI

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
                    ExpensesChart(expensesByCategory: summary.expensesByCategory)
                    
                    ChartLegend(categories: Array(summary.expensesByCategory.keys))
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
