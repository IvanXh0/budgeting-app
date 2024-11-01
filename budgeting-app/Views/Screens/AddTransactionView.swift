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
    @State private var amount = ""
    @State private var category = TransactionCategory.food
    @State private var transactionType = "Expense"

    private var availableCategories: [TransactionCategory] {
        transactionType == "Income" ? TransactionCategory.incomeCategories : TransactionCategory.expenseCategories
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
                    .onChange(of: transactionType) {
                        category = transactionType == "Income" ? TransactionCategory.incomeCategories[0] : TransactionCategory.expenseCategories[1]
                    }
                }

                Section(header: Text("Category")) {
                    Picker("Select Category", selection: $category) {
                        ForEach(availableCategories, id: \.self) { category in
                            Text(category.rawValue).tag(category)
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
                                category: category,
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
