//
//  SummaryItem.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import SwiftUICore

struct SummaryItem: View {
    @EnvironmentObject private var currencyManager: CurrencyManager
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

            Text(currencyManager.formatCurrency(amount))
                .font(.body)
                .bold()
                .foregroundColor(color)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .truncationMode(.tail)
                .multilineTextAlignment(.center)
        }
    }
}
