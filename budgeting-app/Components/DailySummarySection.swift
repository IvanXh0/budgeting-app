//
//  DailySummarySection.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import UIKit


struct DailySummarySection: View {
    @ObservedObject var viewModel: TransactionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today's Transactions")
                .font(.title2)
                .bold()
                .padding(.horizontal)

            DailySummaryView(transactions: viewModel.dailyTransactions())
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(radius: 2))
                .padding(.horizontal)
        }
    }
}
