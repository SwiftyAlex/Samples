//
//  Run.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import Foundation

struct Run: Identifiable, Hashable {
    var id = UUID()
    var distanceKm: Double
    var sleepHours: Double = Double.random(in: 0..<8)
    var day: String
}


// MARK: - useful data
extension Run {
    static let randomisedWeek: [Run] = [
        .init(distanceKm: Double.random(in: 0..<40), day: "Monday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Tuesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Wednesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Thursday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Friday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Saturday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Sunday"),
    ]
}
