//
//  CategoryCell.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import SwiftUI

struct CategoryCell: View {
    
    let category: ItemCategory
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image(iconName)
                .resizable()
                .frame(width: 24 ,height: 24)
                .font(.title2)
            
            Text(category.rawValue)
                .font(.caption)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    private var iconName: String {
        switch category {
        case .dairy: return "milk"
        case .vegetables: return "vegetables"
        case .fruits: return "fruits"
        case .breads: return "breads"
        case .meats: return "meat"
        }
    }
    
    private var backgroundColor: Color {
            switch category {
            case .dairy: return isSelected ? .blue.opacity(0.35) : .gray.opacity(0.2)
            case .vegetables: return isSelected ? .blue.opacity(0.35) : .green.opacity(0.2)
            case .fruits: return isSelected ? .blue.opacity(0.35) : .pink.opacity(0.2)
            case .breads: return isSelected ? .blue.opacity(0.35) : .orange.opacity(0.2)
            case .meats: return isSelected ? .blue.opacity(0.35) : .red.opacity(0.2)
            }
        }
}

#Preview {
    CategoryCell(category: .dairy, isSelected: false)
}
