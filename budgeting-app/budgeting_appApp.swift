//
//  budgeting_appApp.swift
//  budgeting-app
//
//  Created by Ivan Apostolovski on 31.10.24.
//

import SwiftUI

@main
struct BudgetApp: App {
    @StateObject private var categoryManager = CategoryManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(categoryManager)
        }
    }
}
