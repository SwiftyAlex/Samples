//
//  Run.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import Foundation
import SwiftData

@Model final class Run {
    var date: Double
    var kilometers: Double

    init(date: Date, kilometers: Double) {
        self.date = date.timeIntervalSince1970
        self.kilometers = kilometers
    }

    @Transient var actualDate: Date {
        Date(timeIntervalSince1970: date)
    }
}
