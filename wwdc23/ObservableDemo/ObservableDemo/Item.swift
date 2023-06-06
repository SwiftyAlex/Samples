//
//  Item.swift
//  ObservableDemo
//
//  Created by Alex Logan on 06/06/2023.
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
