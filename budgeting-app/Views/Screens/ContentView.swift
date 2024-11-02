//
//  ContentView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var categoryManager = CategoryManager()
    @StateObject var currencyManager = CurrencyManager()
    @StateObject var transactionManager = TransactionManager()
    @StateObject var budgetManager = BudgetManager()
    @State private var showAddTransaction = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // dashboard
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        DailySummarySection()
                        MonthlySummarySection()
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
            TransactionCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1)

            // budget
            BudgetView()
                .tabItem {
                    Label("Budget", systemImage: "chart.pie.fill")
                }
                .tag(3)

            // settings
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .sheet(isPresented: $showAddTransaction) {
            AddTransactionView(categoryManager: categoryManager) // Updated initialization
        }
        .environmentObject(categoryManager)
        .environmentObject(currencyManager)
        .environmentObject(transactionManager)
        .environmentObject(budgetManager)
    }
}
