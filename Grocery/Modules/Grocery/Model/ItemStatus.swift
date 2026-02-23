//
//  ItemStatus.swift
//  Grocery
//
//  Created by Angshuman on 21/02/26.
//

import Foundation

enum ItemStatus: Codable {
    case pending
    case purchased
}

extension ItemStatus {
    var nextStatus: ItemStatus {
        switch self {
        case .pending:
            .purchased
        case .purchased:
            .pending
        }
    }
}
