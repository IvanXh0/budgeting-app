//
//  ContentView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUICore
import SwiftUI


struct ContentView: View {
    @StateObject var viewModel = TransactionViewModel()
    @State private var showAddTransaction = false
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab
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

            // Calendar Tab
            TransactionCalendarView(viewModel: viewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1)
        }
        .sheet(isPresented: $showAddTransaction) {
            AddTransactionView(viewModel: viewModel)
        }
    }
}
