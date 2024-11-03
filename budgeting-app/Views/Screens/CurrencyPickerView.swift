//
//  CurrencyPickerView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 3.11.24.
//

import SwiftUI
import SwiftUICore

struct CurrencyPickerView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currencyManager: CurrencyManager
    @State private var searchText = ""
    
    private var filteredCurrencies: [Currency] {
        if searchText.isEmpty {
            return Currency.allCurrencies
        } else {
            return Currency.allCurrencies.filter { currency in
                currency.name.localizedCaseInsensitiveContains(searchText) ||
                    currency.id.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCurrencies) { currency in
                    Button(action: {
                        currencyManager.selectedCurrency = currency.id
                        UserDefaults.standard.set(currency.id, forKey: "userCurrency")
                        dismiss()
                    }) {
                        HStack {
                            Text(currency.flag)
                                .font(.title2)
                            
                            VStack(alignment: .leading) {
                                Text(currency.name)
                                    .foregroundColor(.primary)
                                Text(currency.id)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text(currency.symbol)
                                .foregroundColor(.gray)
                            
                            if currency.id == currencyManager.selectedCurrency {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search currencies")
            .navigationTitle("Select Currency")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
            })
        }
    }
}
