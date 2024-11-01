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

struct SummaryItem: View {
    let title: String
    let amount: Double
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.body)
                .bold()
                .foregroundColor(color)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
    }
}
