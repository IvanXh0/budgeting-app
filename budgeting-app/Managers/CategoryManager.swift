//
//  CategoryManager.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import Foundation
import SwiftUI

class CategoryManager: ObservableObject {
    @Published private(set) var categories: [CategoryItem] = [] {
        didSet {
            saveCategories()
        }
    }

    private let defaultCategories: [CategoryItem] = [
        // income
        CategoryItem(name: "Salary", icon: "dollarsign.circle.fill", color: .green, isIncome: true, isDefault: true),
        CategoryItem(name: "Gift", icon: "gift.fill", color: .pink, isIncome: true, isDefault: true),
        CategoryItem(name: "Investment", icon: "chart.line.uptrend.xyaxis", color: .purple, isIncome: true, isDefault: true),

        // expenses
        CategoryItem(name: "Food", icon: "fork.knife", color: .blue, isIncome: false, isDefault: true),
        CategoryItem(name: "Transport", icon: "car.fill", color: .green, isIncome: false, isDefault: true),
        CategoryItem(name: "Shopping", icon: "cart.fill", color: .purple, isIncome: false, isDefault: true),
        CategoryItem(name: "Bills", icon: "doc.text.fill", color: .red, isIncome: false, isDefault: true),
        CategoryItem(name: "Entertainment", icon: "gamecontroller.fill", color: .orange, isIncome: false, isDefault: true),
        CategoryItem(name: "Health", icon: "heart.fill", color: .pink, isIncome: false, isDefault: true),
        CategoryItem(name: "Other", icon: "questionmark.circle.fill", color: .gray, isIncome: false, isDefault: true)
    ]

    init() {
        loadCategories()
    }

    var incomeCategories: [CategoryItem] {
        categories.filter { $0.isIncome }
    }

    var expenseCategories: [CategoryItem] {
        categories.filter { !$0.isIncome }
    }

    private func loadCategories() {
        if let savedCategories = UserDefaults.standard.data(forKey: "categories"),
           let decoded = try? JSONDecoder().decode([CategoryItem].self, from: savedCategories)
        {
            categories = decoded
            objectWillChange.send()
        } else {
            categories = defaultCategories
            saveCategories()
        }
    }

    private func saveCategories() {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: "categories")
            objectWillChange.send()
        }
    }

    func addCategory(name: String, icon: String, color: Color, isIncome: Bool) {
        let newCategory = CategoryItem(name: name, icon: icon, color: color, isIncome: isIncome)
        categories.append(newCategory)
        saveCategories()
        objectWillChange.send()
    }

    func deleteCategory(_ category: CategoryItem) {
        if !category.isDefault {
            categories.removeAll { $0.id == category.id }
            saveCategories()
            objectWillChange.send()
        }
    }
}
