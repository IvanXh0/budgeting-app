//
//  SettingsView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import SwiftUI
import SwiftUICore

struct SettingsView: View {
    @EnvironmentObject var categoryManager: CategoryManager
    @EnvironmentObject var currencyManager: CurrencyManager
    @State private var showingAddCategory = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Currency")) {
                    Picker("Select Currency", selection: $currencyManager.selectedCurrency) {
                        ForEach(["USD", "EUR", "MKD"], id: \.self) { currency in
                            Text(currency).tag(currency)
                        }
                    }
                    .onChange(of: currencyManager.selectedCurrency) { _ in
                        UserDefaults.standard.set(currencyManager.selectedCurrency, forKey: "userCurrency")
                    }
                }
                
                Section(header: Text("Income Categories")) {
                    ForEach(categoryManager.incomeCategories) { category in
                        CategoryRow(category: category)
                    }
                    .onDelete { offsets in
                        let incomeCategoriesArray = categoryManager.incomeCategories
                        for index in offsets {
                            let categoryToDelete = incomeCategoriesArray[index]
                            categoryManager.deleteCategory(categoryToDelete)
                        }
                    }
                }
                
                Section(header: Text("Expense Categories")) {
                    ForEach(categoryManager.expenseCategories) { category in
                        CategoryRow(category: category)
                    }
                    .onDelete { offsets in
                        let expenseCategoriesArray = categoryManager.expenseCategories
                        for index in offsets {
                            let categoryToDelete = expenseCategoriesArray[index]
                            categoryManager.deleteCategory(categoryToDelete)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddCategory = true }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddCategory) {
                AddCategoryView(categoryManager: categoryManager)
            }
        }
    }
}
