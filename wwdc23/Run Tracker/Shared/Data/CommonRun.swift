//
//  CommonRun.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import Foundation
import AppIntents

enum CommonRun: Double, CaseIterable, AppEnum {
    typealias RawValue = Double
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(stringLiteral: "Run")

    static var caseDisplayRepresentations: [CommonRun : DisplayRepresentation] = [
        .couchToKitchen: .init(stringLiteral: "Just nipping for another donut"),
        .five: .init(stringLiteral: "5K"),
        .ten: .init(stringLiteral: "10K"),
        .halfMarathon: .init(stringLiteral: "Half Marathon"),
        .marathon: .init(stringLiteral: "Marathon"),
    ]

    case couchToKitchen = 0.05, five = 5, ten = 10, halfMarathon = 21.1, marathon = 42.2

    var title: String {
        switch self {
        case .couchToKitchen: return "Couch to Fridge"
        case .five: return "5K"
        case .ten: return "10K"
        case .halfMarathon: return "Half Marathon"
        case .marathon: return "Marathon"
        }
    }
}
