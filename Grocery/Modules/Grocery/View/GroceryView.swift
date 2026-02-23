//
//  GroceryView.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import SwiftUI
import SwiftData

struct GroceryView<VM: GroceryViewModelProtocol>: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query
    private var list: [GroceryItem]
    
    @State private var showFilter = false
    
    @StateObject var viewModel: VM
    
    init(viewModel: VM = GroceryViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List {
                // MARK: Header Section
                Section {
                    headerView()
                        .listRowSeparator(.hidden)
                }
                
                // MARK: Add Item Section
                Section {
                    CreateItemView(
                        onAddTapped: { itemName, category in
                            viewModel.addItem(modelContext: modelContext)
                        },
                        itemName: $viewModel.itemName,
                        selectedCategory: $viewModel.selectedCategory
                    )
                    .padding(.horizontal, 2)
                    .padding(.vertical, 8)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                
                // MARK: Add Item Section & Items Section
                Section {
                    if viewModel.filteredItems(from: list).isEmpty {
                        emptyView()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    } else {
                        listView()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.white)
            .alert("Update Item",
                   isPresented: Binding(
                    get: { viewModel.editingItem != nil },
                    set: { if !$0 { viewModel.editingItem = nil } }
                   )
            ) {
                
                TextField(
                    "Item Name",
                    text: Binding(
                        get: { viewModel.editingItem?.name ?? "" },
                        set: { viewModel.editingItem?.name = $0 }
                    )
                )
                
                Button("Cancel", role: .cancel) {
                    viewModel.editingItem = nil
                }
                
                Button("Update") {
                    if let item = viewModel.editingItem {
                        viewModel.updateItem(
                            item,
                            update: GroceryItemUpdate(
                                name: item.name,
                                status: nil
                            )
                        )
                    }
                    viewModel.editingItem = nil
                }
            }

        }
    }
}

extension GroceryView {
    func headerView() -> some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                
                Button {
                    showFilter = true
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title2)
                }
            }
            
            Image("shoppingCart")
                .resizable()
                .frame(width: 70, height: 70)
            
            Text("Grocery List")
                .font(.title3)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $showFilter) {
            GroceryFilterView(
                selectedFilter: $viewModel.selectedFilter
            )
        }
    }
    
    func emptyView() -> some View {
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
    }
    
    func listView() -> some View {
        ForEach(viewModel.filteredItems(from: list), id: \.id) { item in
            GroceryListItemView(item: item)
                .onTapGesture {
                    viewModel.editingItem = item
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.deleteItem(item, modelContext: modelContext)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    
                    Button {
                        viewModel.toggleStatus(for: item)
                    } label: {
                        Label(
                            item.status == .pending
                            ? "Purchased"
                            : "Pending",
                            systemImage: item.status == .pending
                            ? "checkmark.circle"
                            : "arrow.uturn.backward.circle"
                        )
                    }
                    .tint(.blue)
                }
        }
    }
}

#Preview {
    GroceryView()
}
