//
//  BudgetManager.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 2.11.24.
//

import Foundation
import UserNotifications

class BudgetManager: ObservableObject {
    @Published var currentBudget: Budget?
    @Published var hasShownFiftyPercentAlert = false
    @Published var hasShownEightyPercentAlert = false
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func setBudget(amount: Double, period: Period, startDate: Date) {
        currentBudget = Budget(amount: amount, period: period, startDate: startDate)
        hasShownFiftyPercentAlert = false
        hasShownEightyPercentAlert = false
        saveBudget()
        saveNotificationFlags()
    }
    
    func resetBudget() {
        currentBudget = nil
        hasShownFiftyPercentAlert = false
        hasShownEightyPercentAlert = false
        UserDefaults.standard.removeObject(forKey: "budget")
        saveNotificationFlags()
    }
    
    func checkBudgetThresholds(currentSpending: Double) {
        guard let budget = currentBudget else { return }
        
        let spendingPercentage = (currentSpending / budget.amount) * 100
        
        if spendingPercentage >= 80 && !hasShownEightyPercentAlert {
            scheduleNotification(
                title: "Budget Alert",
                body: "You've used 80% of your \(budget.period.rawValue) budget!",
                identifier: "eightyPercent"
            )
            hasShownEightyPercentAlert = true
            saveNotificationFlags()
        } else if spendingPercentage >= 50 && !hasShownFiftyPercentAlert {
            scheduleNotification(
                title: "Budget Alert",
                body: "You've used 50% of your \(budget.period.rawValue) budget.",
                identifier: "fiftyPercent"
            )
            hasShownFiftyPercentAlert = true
            saveNotificationFlags()
        }
    }
    
    private func scheduleNotification(title: String, body: String, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func saveNotificationFlags() {
        UserDefaults.standard.set(hasShownFiftyPercentAlert, forKey: "hasShownFiftyPercentAlert")
        UserDefaults.standard.set(hasShownEightyPercentAlert, forKey: "hasShownEightyPercentAlert")
    }
    
    private func loadNotificationFlags() {
        hasShownFiftyPercentAlert = UserDefaults.standard.bool(forKey: "hasShownFiftyPercentAlert")
        hasShownEightyPercentAlert = UserDefaults.standard.bool(forKey: "hasShownEightyPercentAlert")
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
        loadNotificationFlags()
    }
}
