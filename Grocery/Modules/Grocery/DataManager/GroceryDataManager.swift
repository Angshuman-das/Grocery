//
//  GroceryDataManager.swift
//  Grocery
//
//  Created by Angshuman on 22/02/26.
//

import SwiftData

protocol GroceryDataManagerProtocol {
    func addItem(_ item: GroceryItem, modelContext: ModelContext)
    func deleteItem(_ item: GroceryItem, modelContext: ModelContext)
    func updateItem(_ item: GroceryItem, update: GroceryItemUpdate)
}

class GroceryDataManager: GroceryDataManagerProtocol {
    func addItem(_ item: GroceryItem, modelContext: ModelContext) {
        modelContext.insert(item)
    }
    
    func deleteItem(_ item: GroceryItem, modelContext: ModelContext) {
        modelContext.delete(item)
    }
    
    func updateItem(_ item: GroceryItem, update: GroceryItemUpdate) {
        if let name = update.name { item.name = name }
        if let status = update.status { item.status = status }
        if let category = update.category { item.category = category }
    }
}
