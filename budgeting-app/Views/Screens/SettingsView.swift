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
    @EnvironmentObject var transactionManager: TransactionManager
    @State private var showingAddCategory = false
    @State private var showingDeleteHistoryDialog = false
    @State private var showingCurrencyPicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Currency")) {
                    Button(action: {
                        showingCurrencyPicker = true
                    }) {
                        HStack {
                            Text("Select Currency")
                            Spacer()
                            if let currency = Currency.allCurrencies.first(where: { $0.id == currencyManager.selectedCurrency }) {
                                Text("\(currency.flag) \(currency.id) (\(currency.symbol))")
                                    .foregroundColor(.gray)
                            }
                        }
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
                
                Section(header: Text("General")) {
                    Button(action: {
                        showingDeleteHistoryDialog = true
                    }) {
                        Label("Clear All Data", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    .confirmationDialog("Are you sure you want to delete all data? This action is irreversible", isPresented: $showingDeleteHistoryDialog, titleVisibility: .visible) {
                        Button("Confirm", role: .destructive) {
                            transactionManager.deleteAllTransactions()
                        }
                        Button("Cancel", role: .cancel) {
                            showingDeleteHistoryDialog = false
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
            .sheet(isPresented: $showingCurrencyPicker) {
                CurrencyPickerView()
            }
            .sheet(isPresented: $showingAddCategory) {
                AddCategoryView(categoryManager: categoryManager)
            }
        }
    }
}
