//
//  TransactionRow.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore

struct TransactionRow: View {
    let transaction: Transaction
    @EnvironmentObject var currencyManager: CurrencyManager

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: transaction.category.icon)
                .foregroundColor(transaction.category.color)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(transaction.category.color.opacity(0.2))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.name)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(currencyManager.formatCurrency(transaction.amount, isIncome: transaction.isIncome))
                .font(.headline)
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}
