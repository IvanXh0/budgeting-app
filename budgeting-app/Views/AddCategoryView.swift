//
//  AddCategoryView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 1.11.24.
//

import SwiftUI
import SwiftUICore

struct AddCategoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var categoryManager: CategoryManager
    @State private var name = ""
    @State private var selectedIcon = "tag.fill"
    @State private var selectedColor = Color.blue
    @State private var isIncome = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Category Name", text: $name)
                
                Picker("Type", selection: $isIncome) {
                    Text("Expense").tag(false)
                    Text("Income").tag(true)
                }
                
                ColorPicker("Color", selection: $selectedColor)
                
                // Add icon picker here...
            }
            .navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        categoryManager.addCategory(
                            name: name,
                            icon: selectedIcon,
                            color: selectedColor,
                            isIncome: isIncome
                        )
                        
                        DispatchQueue.main.async {
                            categoryManager.objectWillChange.send()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty)
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
