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
        HStack(spacing: 16) { // Increased spacing from 12 to 16
            Image(systemName: transaction.category.icon)
                .foregroundColor(transaction.category.color)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(transaction.category.color.opacity(0.2))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(transaction.isIncome ? "+$\(transaction.amount, specifier: "%.2f")" : "-$\(transaction.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16) 
    }
}
