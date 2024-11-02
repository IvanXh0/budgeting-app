//
//  Budget.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 2.11.24.
//

import Foundation

struct Budget: Identifiable, Codable {
    var id = UUID()
    var amount: Double
    var period: Period
    var startDate: Date
}

enum Period: String, Codable {
    case monthly
    case weekly
    case yearly
}
