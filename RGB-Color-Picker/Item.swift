//
//  Item.swift
//  RGB-Color-Picker
//
//  Created by Constantine Grinko on 03.10.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
