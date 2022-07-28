//
//  CoffeeOrderActivity.swift
//  live-activity
//
//  Created by Alex Logan on 28/07/2022.
//

import Foundation
import ActivityKit

struct CoffeeDeliveryAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var currentStatus: CoffeeDeliveryStatus
    }
    var coffeeName: String
}


enum CoffeeDeliveryStatus: Codable, Sendable, CaseIterable {
    case recieved, preparing, outForDelivery

    var displayText: String {
        switch self {
        case .recieved:
            return "Recieved"
        case .preparing:
            return "Brewing"
        case .outForDelivery:
            return "On its way!"
        }
    }
}
