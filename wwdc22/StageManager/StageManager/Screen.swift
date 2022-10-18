//
//  Screen.swift
//  StageManager
//
//  Created by Alex Logan on 12/09/2022.
//

import Foundation

enum Screen: Int, Hashable, CaseIterable {
    case basketball = 0, soccer, racing
    
    var iconName: String {
        switch self {
        case .basketball:
            return "basketball.fill"
        case .soccer:
            return "soccerball"
        case .racing:
            return "car.fill"
        }
    }
    
    var displayText: String {
        switch self {
        case .basketball:
            return "Basketball"
        case .soccer:
            return "Soccer"
        case .racing:
            return "Racing"
        }
    }
}
