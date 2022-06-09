//
//  GaugeWidgetView.swift
//  Widgets
//
//  Created by Alex Logan on 09/06/2022.
//

import SwiftUI
import WidgetKit

struct GaugeWidgetView: View {
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = false
        formatter.allowsFloats = true
        return formatter
    }

    let distanceRun: Double = 23.7
    let distanceGoal = 80

    var body: some View {
        ZStack {
            Gauge(
                value: distanceRun, in: 0...80
            ) { }
            .gaugeStyle(.accessoryCircularCapacity)
            Text("\(numberFormatter.string(from: NSNumber(value: distanceRun)) ?? "0") km")
                .font(.caption.weight(.semibold))
        }
    }
}

struct GaugeWidget_Previews: PreviewProvider {
    static var previews: some View {
        GaugeWidgetView()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
