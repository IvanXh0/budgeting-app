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
            // Main View with Daily and Monthly Summary
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        // Daily Summary Section
                        VStack(alignment: .leading) {
                            Text("Today's Transactions")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            DailySummaryView(transactions: viewModel.dailyTransactions())
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(UIColor.systemBackground))
                                    .shadow(radius: 2))
                                .padding(.horizontal)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // Monthly Summary Section
                        VStack(alignment: .leading) {
                            Text("Monthly Overview")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            MonthlySummaryView(summary: viewModel.monthlySummary())
                        }
                    }
                    .padding(.vertical)
                }
                .navigationTitle("Budget Tracker")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAddTransaction = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("Dashboard", systemImage: "house.fill")
            }
            .tag(0)
            
            // Calendar View Tab
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
