//
//  GroceryViewModel.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import Foundation
import Combine
import SwiftData

protocol GroceryViewModelProtocol: ObservableObject {
    // create items
    var itemName: String { get set }
    var selectedCategory: ItemCategory? { get set }
    
    var selectedFilter: GroceryFilter { get set }
    var editingItem: GroceryItem? { get set }
    
    func filteredItems(from items: [GroceryItem]) -> [GroceryItem]
    
    func addItem(modelContext: ModelContext)
    func updateItem(_ item: GroceryItem, update: GroceryItemUpdate)
    func deleteItem(_ item: GroceryItem, modelContext: ModelContext)
    func toggleStatus(for item: GroceryItem)
}

class GroceryViewModel: GroceryViewModelProtocol {
    
    @Published var itemName: String = ""
    @Published var selectedCategory: ItemCategory?
    
    @Published var selectedFilter: GroceryFilter = .all
    @Published var editingItem: GroceryItem?
    
    private var dataManager: GroceryDataManagerProtocol
    
    init(
        dataManager: GroceryDataManagerProtocol = GroceryDataManager()
    ) {
        self.dataManager = dataManager
    }
    
    func addItem(modelContext: ModelContext) {
        guard let selectedCategory,
              !itemName.isEmpty else { return }
        
        let groceryItem = GroceryItem(name: itemName, category: selectedCategory)
        dataManager.addItem(groceryItem, modelContext: modelContext)
        resetFeilds()
    }
    
    func updateItem(_ item: GroceryItem, update: GroceryItemUpdate) {
        dataManager.updateItem(item, update: update)
    }
    
    func deleteItem(_ item: GroceryItem, modelContext: ModelContext) {
        dataManager.deleteItem(item, modelContext: modelContext)
    }
    
    func filteredItems(from items: [GroceryItem]) -> [GroceryItem] {
            switch selectedFilter {
            case .all:
                return items.sorted { $0.createdAt > $1.createdAt }
                
            case .category(let category):
                return items
                    .filter { $0.category == category }
                    .sorted { $0.createdAt > $1.createdAt }
            }
        }
    
    func toggleStatus(for item: GroceryItem) {
            updateItem(
                item,
                update: GroceryItemUpdate(
                    name: nil,
                    status: item.status.nextStatus
                )
            )
        }
}

extension GroceryViewModel {
    func resetFeilds() {
        self.itemName = ""
        self.selectedCategory = nil
    }
}
