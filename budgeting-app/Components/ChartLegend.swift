//
//  ChartLegend.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import SwiftUI
import SwiftUICore

struct ChartLegend: View {
    let categories: [CategoryItem]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { category in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(category.color)
                            .frame(width: 14, height: 14)
                        Text(category.name)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
