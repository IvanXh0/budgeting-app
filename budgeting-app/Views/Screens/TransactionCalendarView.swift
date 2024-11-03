//
//  TransactionCalendarView.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI

struct TransactionCalendarView: View {
    @EnvironmentObject var transactionManager: TransactionManager
    @EnvironmentObject var currencyManager: CurrencyManager
    @State private var selectedDate = Date()
    @State private var isCalendarExpanded = true
    
    private let maxCalendarHeight: CGFloat = 380
    private let minCalendarHeight: CGFloat = 80
    
    private var dayTransactions: [Transaction] {
        transactionManager.transactions
            .filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            .sorted { $0.date > $1.date }
    }
    
    private var dailyTotal: Double {
        let income = dayTransactions.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
        let expenses = dayTransactions.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
        return income - expenses
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { _ in
                ScrollView {
                    VStack(spacing: 0) {
                        calendarSection
                            .id("calendar")
                            .background(Color(UIColor.systemBackground))
                        
                        dailySummarySection
                        
                        transactionsList
                    }
                }
                .coordinateSpace(name: "scroll")
                .background(Color(UIColor.systemGroupedBackground))
                .navigationTitle("Calendar")
                .navigationBarTitleDisplayMode(.inline)
                // Track scroll position using simultaneousGesture
                .simultaneousGesture(
                    DragGesture(coordinateSpace: .named("scroll"))
                        .onChanged { value in
                            let threshold: CGFloat = 50
                            if value.translation.height < -threshold, isCalendarExpanded {
                                withAnimation(.spring(response: 0.3)) {
                                    isCalendarExpanded = false
                                }
                            } else if value.translation.height > threshold, !isCalendarExpanded {
                                withAnimation(.spring(response: 0.3)) {
                                    isCalendarExpanded = true
                                }
                            }
                        }
                )
            }
        }
    }
    
    private var calendarSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text(selectedDate.formatted(.dateTime.month().year()))
                    .font(.title2.bold())
                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.3)) {
                        isCalendarExpanded.toggle()
                    }
                }) {
                    Image(systemName: isCalendarExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            .padding()
            
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal)
            .frame(height: isCalendarExpanded ? maxCalendarHeight : minCalendarHeight)
            .clipped()
            .opacity(isCalendarExpanded ? 1 : 0.5)
        }
    }
    
    private var dailySummarySection: some View {
        Group {
            if !dayTransactions.isEmpty {
                VStack(spacing: 12) {
                    HStack {
                        Text(selectedDate.formatted(.dateTime.day().month()))
                            .font(.headline)
                        Spacer()
                        Text(currencyManager.formatCurrency(dailyTotal))
                            .font(.headline)
                            .foregroundColor(dailyTotal >= 0 ? .green : .red)
                    }
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Income")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(currencyManager.formatCurrency(
                                dayTransactions.filter { $0.isIncome }.reduce(0) { $0 + $1.amount }
                            ))
                            .foregroundColor(.green)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Expenses")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(currencyManager.formatCurrency(
                                dayTransactions.filter { !$0.isIncome }.reduce(0) { $0 + $1.amount }
                            ))
                            .foregroundColor(.red)
                        }
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top)
            }
        }
    }
    
    private var transactionsList: some View {
        LazyVStack(spacing: 8) {
            if dayTransactions.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("No transactions on \(selectedDate.formatted(.dateTime.day().month()))")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
            } else {
                ForEach(dayTransactions) { transaction in
                    TransactionRow(transaction: transaction)
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }
}
