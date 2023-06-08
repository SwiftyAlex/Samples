//
//  Run.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import Foundation
import SwiftData


@Model final class Run {
    var date: Date
    var kilometers: Double

    init(date: Date, kilometers: Double) {
        self.date = date
        self.kilometers = kilometers
    }
}
