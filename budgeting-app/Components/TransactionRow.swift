//
//  TransactionRow.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI
import SwiftUICore

struct TransactionRow: View {
    let transaction: Transaction
    @EnvironmentObject var currencyManager: CurrencyManager
    @EnvironmentObject var transactionManager: TransactionManager
    @State private var showDeleteAlert = false
    @GestureState private var isLongPressing = false

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
        .background(Color(UIColor.systemBackground))
        .contentShape(Rectangle())
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .updating($isLongPressing) { currentState, gestureState, _ in
                    gestureState = currentState
                }
                .onEnded { _ in
                    showDeleteAlert = true
                }
        )
        .scaleEffect(isLongPressing ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLongPressing)
        .alert("Delete Transaction", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    transactionManager.deleteTransaction(transaction)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this transaction?")
        }
    }
}
