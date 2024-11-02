//
//  MonthlySummarySection.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import UIKit

struct MonthlySummarySection: View {
    @EnvironmentObject var transactionManager: TransactionManager

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Monthly Overview")
                .font(.title2)
                .bold()
                .padding(.horizontal)

            MonthlySummaryView(summary: transactionManager.monthlySummary())
        }
    }
}
