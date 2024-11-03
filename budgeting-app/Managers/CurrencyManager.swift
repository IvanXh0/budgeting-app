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

    func formatCurrency(_ amount: Double, isIncome: Bool? = nil, addSigns: Bool? = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencyCode = selectedCurrency

        let number = NSNumber(value: abs(amount))
        let formattedNumber = formatter.string(from: number) ?? ""

        if addSigns == false {
            return formattedNumber
        }

        if let isIncome = isIncome {
            return isIncome ? "+\(formattedNumber)" : "-\(formattedNumber)"
        } else {
            return amount >= 0 ? "+\(formattedNumber)" : "-\(formattedNumber)"
        }
    }
}
