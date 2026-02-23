//
//  GroceryItem.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import Foundation
import SwiftData

@Model
class GroceryItem: Identifiable {
    @Attribute(.unique)
    var id: String
    
    var name: String
    var category: ItemCategory
    var status: ItemStatus
    var createdAt: Date
    
    init(
        id: String = UUID().uuidString,
        name: String,
        category: ItemCategory,
        status: ItemStatus = .pending,
        createdAt: Date = .init()
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.status = status
        self.createdAt = createdAt
    }
}
