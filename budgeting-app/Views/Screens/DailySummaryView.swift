//
//  DailySummaryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore


struct DailySummaryView: View {
    let transactions: [Transaction]
    
    var dailyTotal: Double {
        let income = transactions.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
        let expenses = transactions.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
        return income - expenses
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Today's Overview")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f", dailyTotal))
                    .font(.headline)
                    .foregroundColor(dailyTotal >= 0 ? .green : .red)
            }
            .padding(.horizontal)
            
            if transactions.isEmpty {
                Text("No transactions today")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(transactions) { transaction in
                    TransactionRow(transaction: transaction)
                }
            }
        }
        .padding(.vertical)
    }
}
