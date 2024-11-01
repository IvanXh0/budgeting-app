//
//  SummaryCard.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import UIKit

struct SummaryCard: View {
    let income: Double
    let expenses: Double
    let balance: Double

    var body: some View {
        HStack(spacing: 16) {
            SummaryItem(title: "Income", amount: income, color: .green)
            Text("|")
                .font(.headline)
                .foregroundColor(.primary)
            SummaryItem(title: "Expenses", amount: expenses, color: .red)
            Text("|")
                .font(.headline)
                .foregroundColor(.primary)
            SummaryItem(title: "Balance", amount: balance, color: .blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
