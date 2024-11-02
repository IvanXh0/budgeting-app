//
//  Transaction.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import Foundation
import SwiftUICore

struct Transaction: Identifiable, Codable, Equatable {
    var id = UUID()
    var amount: Double
    var category: CategoryItem
    var date: Date
    var isIncome: Bool
}
