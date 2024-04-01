//
//  Item.swift
//  MC1-Koturu
//
//  Created by Timothy Andrian on 01/04/24.
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
