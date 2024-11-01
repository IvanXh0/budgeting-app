//
//  ExpensesChart.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import Charts
import SwiftUI

struct ExpensesChart: View {
    let expensesByCategory: [CategoryItem: Double]

    var body: some View {
        Chart {
            ForEach(Array(expensesByCategory.sorted(by: { $0.value > $1.value })), id: \.key) { item in
                SectorMark(
                    angle: .value("Amount", item.value),
                    innerRadius: .ratio(0.5),
                    angularInset: 1.0
                )
                .foregroundStyle(item.key.color)
                .annotation(position: .overlay) {
                    VStack(spacing: 2) {
                        Text(item.key.name)
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.white)
                        Text(item.value, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                    .padding(4)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(4)
                }
            }
        }
        .frame(height: 300)
        .padding(.horizontal)
    }
}
