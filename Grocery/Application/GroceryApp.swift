//
//  GroceryApp.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import SwiftUI
import SwiftData

@main
struct GroceryApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GroceryView()
            }
        }
        .modelContainer(for: GroceryItem.self)
    }
}
