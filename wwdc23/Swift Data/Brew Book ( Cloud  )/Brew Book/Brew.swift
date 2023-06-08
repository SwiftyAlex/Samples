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
    var brewIdentifier: UUID = UUID()
    var type: BrewType.RawValue = BrewType.espresso.rawValue
    var rating: Int = 5
    var brewDate: Date = Date()

    var brewer: Brewer?

    init(
        brewIdentifier: UUID = .init(),
        type: BrewType,
        rating: Int,
        brewDate: Date
    ) {
        self.brewIdentifier = brewIdentifier
        self.type = type.rawValue
        self.rating = rating
        self.brewDate = brewDate
    }
}

extension Brew {
    @Transient
    var brewType: BrewType {
        BrewType(rawValue: self.type) ?? .espresso
    }
}

enum BrewType: String, Codable, CaseIterable, Hashable {
    case espresso = "Espresso", aeropress = "AeroPress", filter = "Filter"
}
