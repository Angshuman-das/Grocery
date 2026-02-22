//
//  GroceryViewModel.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import Foundation
import Combine

protocol GroceryViewModelProtocol: ObservableObject {
    func addItem()
    func updateItem()
    func deleteItem()
}

