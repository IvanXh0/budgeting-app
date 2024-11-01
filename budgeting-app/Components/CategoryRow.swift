//
//  CategoryRow.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import SwiftUICore

struct CategoryRow: View {
    let category: CategoryItem
    
    var body: some View {
        HStack {
            Image(systemName: category.icon)
                .foregroundColor(category.color)
            
            Text(category.name)
            
            Spacer()
            
            if category.isDefault {
                Text("Default")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
