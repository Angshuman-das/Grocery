//
//  GroceryFilterView.swift
//  Grocery
//
//  Created by Angshuman on 23/02/26.
//

import SwiftUI

struct GroceryFilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedFilter: GroceryFilter
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        selectedFilter = .all
                        dismiss()
                    } label: {
                        HStack {
                            Text("All")
                            Spacer()
                            if selectedFilter == .all {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
                
                Section("Categories") {
                    ForEach(ItemCategory.allCases, id: \.self) { category in
                        Button {
                            selectedFilter = .category(category)
                            dismiss()
                        } label: {
                            HStack {
                                Text(category.rawValue)
                                Spacer()
                                if selectedFilter == .category(category) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filter")
        }
    }
}

#Preview {
    GroceryFilterView(selectedFilter: .constant(.category(.breads)))
}
