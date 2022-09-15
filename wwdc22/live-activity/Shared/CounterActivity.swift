//
//  CounterActivity.swift
//  widgetExtension
//
//  Created by Alex Logan on 15/09/2022.
//

import Foundation
import ActivityKit

struct CounterActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var count: Int
    }
}
