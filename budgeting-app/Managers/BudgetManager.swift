//
//  BudgetManager.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 2.11.24.
//

import Foundation

class BudgetManager: ObservableObject {
    @Published var currentBudget: Budget?

    func setBudget(amount: Double, period: Period, startDate: Date) {
        currentBudget = Budget(amount: amount, period: period, startDate: startDate)
        saveBudget()
    }

    private func saveBudget() {
        if let encoded = try? JSONEncoder().encode(currentBudget) {
            UserDefaults.standard.set(encoded, forKey: "budget")
        }
    }

    func loadBudget() {
        if let savedBudget = UserDefaults.standard.data(forKey: "budget"),
           let decoded = try? JSONDecoder().decode(Budget.self, from: savedBudget)
        {
            currentBudget = decoded
        }
    }

    func resetBudget() {
        currentBudget = nil
        UserDefaults.standard.removeObject(forKey: "budget")
    }
}
