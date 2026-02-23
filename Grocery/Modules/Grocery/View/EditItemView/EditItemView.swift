//
//  EditItemView.swift
//  Grocery
//
//  Created by Angshuman on 23/02/26.
//

import SwiftUI

struct EditItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State var category: ItemCategory
    
    let item: GroceryItem
    let onUpdate: (String?, ItemCategory?) -> Void
    
    init(
        item: GroceryItem,
        onUpdate: @escaping (String?, ItemCategory?) -> Void
    ) {
        self.item = item
        self._name = State(initialValue: item.name)
        self._category = State(initialValue: item.category)
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Item Name") {
                    TextField("Name", text: $name)
                }
                
                Section("Category") {
                    
                    Picker("Category", selection: $category) {
                        ForEach(ItemCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }                }
            }
            .navigationTitle("Update Item")
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Update") {
                        onUpdate(name, category)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    EditItemView(item: .init(name: "Bread", category: .breads)) { item, category in
        //
    }
}
