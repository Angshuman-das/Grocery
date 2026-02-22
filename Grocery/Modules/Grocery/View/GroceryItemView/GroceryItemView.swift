//
//  CreateItemView.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import SwiftUI

struct CreateItemView: View {
    
    // MARK: - Public API
    let onAddTapped: (_ itemName: String, _ category: ItemCategory?) -> Void
    
    // MARK: - Private State
    @State private var itemName: String = ""
    @State private var selectedCategory: ItemCategory?
    
    private let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 12)
    ]
    
    private var isEnabled: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty
        && selectedCategory != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            titleView()
            
            Group {
                addItemSection()
                addCategorySection()
                addButtonSection()
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, 2)
        .padding(.bottom, 20)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.8), lineWidth: 1)
                .blur(radius: 1)
                .offset(x: -1, y: -1)
                .mask(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [.white, .clear],
                                startPoint: .topLeading,
                                endPoint: .center
                            )
                        )
                )
        )
        .shadow(color: .black.opacity(0.08),
                radius: 20,
                x: 0,
                y: 12)
        .padding(.horizontal, 2)
    }
}

// MARK: - Title
private extension CreateItemView {
    
    func titleView() -> some View {
        HStack {
            Text("Add New Item")
                .font(.subheadline.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(height: 48)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.9),
                    Color.blue
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func sectionTitleView(title: String) -> some View {
        Text(title)
            .font(.system(size: 14, weight: .bold))
    }
}

// MARK: - Item Section
private extension CreateItemView {
    
    func addItemSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            sectionTitleView(title: "Item Name")
            
            TextField("Enter grocery item...", text: $itemName)
                .padding(.horizontal, 12)
                .frame(height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isEnabled ? .blue.opacity(0.3) : .gray.opacity(0.2))
                )
        }
    }
}

// MARK: - Category Section
private extension CreateItemView {
    
    func addCategorySection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            
            sectionTitleView(title: "Category")
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(ItemCategory.allCases, id: \.self) { category in
                    CategoryCell(
                        category: category,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
        }
    }
}

// MARK: - Button
private extension CreateItemView {
    
    func addButtonSection() -> some View {
        Button {
            guard isEnabled else { return }
            onAddTapped(itemName, selectedCategory)
        } label: {
            HStack {
                Spacer()
                
                Image(systemName: "plus")
                Text("Add Item")
                    .font(.subheadline.weight(.bold))
                
                Spacer()
            }
            .frame(height: 48)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isEnabled ? Color.blue : Color.gray.opacity(0.5))
            )
        }
        .disabled(!isEnabled)
    }
}

#Preview {
    CreateItemView { itemName, category in
        print("Added:", itemName, category ?? "nil")
    }
}
