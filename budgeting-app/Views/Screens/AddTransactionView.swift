//
//  AddTransactionView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TransactionViewModel
    @EnvironmentObject var categoryManager: CategoryManager
    @State private var amount = ""
    @State private var transactionType = "Expense"
    @State private var selectedCategory: CategoryItem
    
    init(viewModel: TransactionViewModel, categoryManager: CategoryManager) {
        self.viewModel = viewModel
        let defaultCategory = categoryManager.expenseCategories.first ??
            CategoryItem(name: "Other", icon: "questionmark.circle.fill", color: .gray, isIncome: false, isDefault: true)
        _selectedCategory = State(initialValue: defaultCategory)
    }
    
    private var availableCategories: [CategoryItem] {
        transactionType == "Income" ? categoryManager.incomeCategories : categoryManager.expenseCategories
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Picker("Type", selection: $transactionType) {
                        Text("Expense").tag("Expense")
                        Text("Income").tag("Income")
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: transactionType) { newValue in
                        if newValue == "Income" {
                            if let firstIncome = categoryManager.incomeCategories.first {
                                selectedCategory = firstIncome
                            }
                        } else {
                            if let firstExpense = categoryManager.expenseCategories.first {
                                selectedCategory = firstExpense
                            }
                        }
                    }
                }
                
                Section(header: Text("Category")) {
                    List {
                        ForEach(availableCategories) { category in
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(category.color)
                                Text(category.name)
                                Spacer()
                                if selectedCategory.id == category.id {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedCategory = category
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let amountValue = Double(amount) {
                            viewModel.addTransaction(
                                amount: amountValue,
                                category: selectedCategory,
                                isIncome: transactionType == "Income"
                            )
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(amount.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
