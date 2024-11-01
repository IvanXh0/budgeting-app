//
//  ContentView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI
import SwiftUICore

struct ContentView: View {
    @StateObject var viewModel = TransactionViewModel()
    @StateObject var categoryManager = CategoryManager()
    @StateObject var currencyManager = CurrencyManager()
    @State private var showAddTransaction = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // dashboard
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        DailySummarySection(viewModel: viewModel)
                        MonthlySummarySection(viewModel: viewModel)
                    }
                    .padding()
                }
                .navigationTitle("Budget Tracker")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAddTransaction = true }) {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("Add Transaction")
                    }
                }
            }
            .tabItem {
                Label("Dashboard", systemImage: "house.fill")
            }
            .tag(0)

            // calendar
            TransactionCalendarView(viewModel: viewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1)

            // settings
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .sheet(isPresented: $showAddTransaction) {
            AddTransactionView(viewModel: viewModel, categoryManager: categoryManager)
                .environmentObject(categoryManager)
        }
        .environmentObject(categoryManager)
        .environmentObject(currencyManager)
    }
}
