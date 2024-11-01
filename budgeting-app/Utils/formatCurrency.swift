//
//  formatCurrency.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import Foundation

private let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    return formatter
}()

func formatCurrency(_ amount: Double, isIncome: Bool? = nil) -> String {
    let number = NSNumber(value: abs(amount))
    let formattedNumber = currencyFormatter.string(from: number) ?? ""

    if let isIncome = isIncome {
        return isIncome ? "+\(formattedNumber)" : "-\(formattedNumber)"
    } else {
        return amount >= 0 ? "+\(formattedNumber)" : "-\(formattedNumber)"
    }
}
