//
//  CategoryItem.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import Foundation
import SwiftUI

struct CategoryItem: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var name: String
    var icon: String
    var colorHex: String
    var isIncome: Bool
    var isDefault: Bool

    init(id: UUID = UUID(), name: String, icon: String, color: Color, isIncome: Bool, isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.icon = icon
        self.colorHex = color.toHex() ?? "#808080"
        self.isIncome = isIncome
        self.isDefault = isDefault
    }

    var color: Color {
        Color(hex: colorHex) ?? .gray
    }
}
