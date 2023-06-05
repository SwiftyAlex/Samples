//
//  Brew.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import Foundation
import SwiftData

@Model
final class Brew {
    @Attribute(.unique) var brewIdentifier: UUID
    var type: BrewType
    var rating: Int
    var brewDate: Date

    var brewer: Brewer?

    init(
        brewIdentifier: UUID = .init(),
        type: BrewType,
        rating: Int,
        brewDate: Date
    ) {
        self.brewIdentifier = brewIdentifier
        self.type = type
        self.rating = rating
        self.brewDate = brewDate
    }
}

//extension Brew {
//    // Temporary workaround because if you don't do this, on second launch, it crashes
//    var brewType: BrewType {
//        BrewType(rawValue: self.type) ?? .espresso
//    }
//}

enum BrewType: String, Codable, CaseIterable, Hashable {
    case espresso = "Espresso", aeropress = "AeroPress", filter = "Filter"
}
