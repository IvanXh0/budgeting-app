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

    // Array of icon names to display
    private let availableIcons: [String] = [
        "tag.fill", "dollarsign.circle.fill", "gift.fill", "chart.line.uptrend.xyaxis",
        "fork.knife", "car.fill", "cart.fill", "doc.text.fill",
        "gamecontroller.fill", "heart.fill", "questionmark.circle.fill"
    ]

    var body: some View {
        NavigationView {
            Form {
                TextField("Category Name", text: $name)

                Picker("Type", selection: $isIncome) {
                    Text("Expense").tag(false)
                    Text("Income").tag(true)
                }

                ColorPicker("Color", selection: $selectedColor)

                Section(header: Text("Select Icon")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(availableIcons, id: \.self) { icon in
                                Button(action: {
                                    selectedIcon = icon
                                }) {
                                    Image(systemName: icon)
                                        .font(.system(size: 30))
                                        .padding()
                                        .foregroundColor(selectedColor)
                                        .background(selectedIcon == icon ? selectedColor.opacity(0.3) : Color.clear)
                                        .cornerRadius(10)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.vertical)
                    }
                }
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
