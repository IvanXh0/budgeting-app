//
//  CurrencyManager.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import Foundation

class CurrencyManager: ObservableObject {
    @Published var selectedCurrency: String {
        didSet {
            UserDefaults.standard.set(selectedCurrency, forKey: "userCurrency")
        }
    }

    init() {
        self.selectedCurrency = UserDefaults.standard.string(forKey: "userCurrency")
            ?? Locale.current.currency?.identifier
            ?? "USD"
    }

    func formatCurrency(_ amount: Double, isIncome: Bool? = nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = selectedCurrency

        let number = NSNumber(value: abs(amount))
        let formattedNumber = formatter.string(from: number) ?? ""

        if let isIncome = isIncome {
            return isIncome ? "+\(formattedNumber)" : "-\(formattedNumber)"
        } else {
            return amount >= 0 ? "+\(formattedNumber)" : "-\(formattedNumber)"
        }
    }
}
