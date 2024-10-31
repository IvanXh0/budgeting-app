//
//  MonthlySummarySection.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import UIKit


struct MonthlySummarySection: View {
    @ObservedObject var viewModel: TransactionViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Monthly Overview")
                .font(.title2)
                .bold()
                .padding(.horizontal)

            MonthlySummaryView(summary: viewModel.monthlySummary())
        }
    }
}
