//
//  ChartModel.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import Foundation
import Combine
import SwiftUI

struct ChartValue: Equatable {
    // The value for our graphics, i.e 0.4
    let value: Double
    // The value a user would see, i.e 50
    let underlyingValue: Double
}

class ChartModel {
    let values: [ChartValue]
    let unit: String
    let title: String

    init(
        values: [ChartValue],
        unit: String,
        title: String
    ) {
        self.values = values
        self.unit = unit
        self.title = title
    }
}



extension ChartModel {
    static func from(rawValues: [Double], unit: String, title: String) -> ChartModel? {
        // We can't have a chart with only one value, and we need the biggest to build a proper chart.
        guard rawValues.count > 1, let largestValue = rawValues.sorted(by: >).first else {
            return nil
        }
        // Get the decimal percentage of the maximum
        let chartValues = rawValues.map { rawValue -> ChartValue in
            let value = rawValue / largestValue
            return ChartValue(value: max(0, value), underlyingValue: rawValue)
        }
        return ChartModel(values: chartValues, unit: unit, title: title)
    }
}
