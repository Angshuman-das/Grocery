//
//  GroceryView.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import SwiftUI

struct GroceryView: View {
    
    @State private var list: [GroceryItem] = [
        GroceryItem(name: "milk", category: .dairy),
        GroceryItem(name: "brinjal", category: .vegetables)
    ]
    
    var body: some View {
        List {
            // MARK: Header Section
            Section {
                VStack(spacing: 12) {
                    Image("shoppingCart")
                        .resizable()
                        .frame(width: 70, height: 70)
                    
                    Text("Grocery List")
                        .font(.title3)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
            }
            
            // MARK: Add Item Section
            Section {
                CreateItemView { itemName, category in
                    let newItem = GroceryItem(name: itemName, category: category!)
                    list.append(newItem)
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 8)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            
            // MARK: Items Section
            Section {
                if list.isEmpty {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image(systemName: "cart")
                                .resizable()
                                .frame(width: 54, height: 54)
                            
                            Text("Your Grocery list is empty")
                                .bold()
                            
                            Text("Add items above to get started")
                                .padding()
                        }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                } else {
                    ForEach(list, id: \.id) { item in
                        GroceryListItemView(item: item)
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .listRowBackground(Color.clear)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
}
#Preview {
    GroceryView()
}
