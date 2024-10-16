//
//  Item.swift
//  Polymorphism
//
//  Created by Ouimin Lee on 9/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var id: UUID
    
    init(timestamp: Date, id: UUID)
    {
        self.timestamp = timestamp
        self.id = id
    }
}
