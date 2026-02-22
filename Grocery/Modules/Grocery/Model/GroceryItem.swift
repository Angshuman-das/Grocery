//
//  GroceryItem.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import Foundation

struct GroceryItem: Identifiable {
    let id: String
    var name: String
    var category: ItemCategory
    var status: ItemStatus
    
    init(
        id: String = UUID().uuidString,
        name: String,
        category: ItemCategory,
        status: ItemStatus = .pending
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.status = status
    }
}
