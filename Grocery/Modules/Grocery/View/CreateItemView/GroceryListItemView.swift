//
//  GroceryListItemView.swift
//  Grocery
//
//  Created by Angshuman on 22/02/26.
//

import SwiftUI

struct GroceryListItemView: View {
    var item: GroceryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                        .bold()
                    
                    Text(item.category.rawValue)
                        .font(.callout)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    GroceryListItemView(item: .init(name: "Apple", category: .fruits))
}
