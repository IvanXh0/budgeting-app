//
//  TransactionCalendarView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI
import SwiftUICore

struct TransactionCalendarView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()

                if let dayTransactions = transactionsForDate(), !dayTransactions.isEmpty {
                    List {
                        ForEach(dayTransactions) { transaction in
                            TransactionRow(transaction: transaction)
                        }
                    }
                } else {
                    Text("No transactions on this date")
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
                    }
            .navigationTitle("Calendar")
        }
    }

    private func transactionsForDate() -> [Transaction]? {
        let filtered = transactionManager.transactions.filter {
            Calendar.current.isDate($0.date, inSameDayAs: selectedDate)
        }
        return filtered.isEmpty ? nil : filtered.sorted { $0.date > $1.date }
    }
}
