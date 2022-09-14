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
    
    var longText: String {
        switch self {
        case .recieved:
            return "We've recieved your order."
        case .preparing:
            return "Our baristas are hard at work brewing up your cup!"
        case .outForDelivery:
            return "Get ready, your brew is speeding over to you right now."
        }
    }
}
