//
//  BarChart.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import Foundation
import SwiftUI

struct BarChart: ChartView {
    let insets: CGFloat = 8
    let strokeWidth: CGFloat = 6
    var color: Color = .teal
    let graphHeight: CGFloat
    
    var model: ChartModel
    
    static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            highestLabel
            chart
                .frame(height: graphHeight)
            lowestLabel

        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(UIColor.systemBackground))
        )
    }
    
    var highestLabel: some View {
        HStack(alignment: .top) {
            Spacer()
            if let biggestValue = model.values.sorted(by: { $0.underlyingValue > $1.underlyingValue }).first {
                labelText(underlyingValue: biggestValue.underlyingValue)
            }
        }
    }
    
    var lowestLabel: some View {
        HStack(alignment: .bottom) {
            Spacer()
            labelText(underlyingValue: 0)
        }
    }
    
    func labelText(underlyingValue: Double) -> some View {
        Text("\(Self.numberFormatter.string(from: NSNumber(value: underlyingValue)) ?? "") \(model.unit)")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    
    
    var chart: some View {
        Canvas { context, size in
            let barWidth: CGFloat = 12
            let halfBarWidth: CGFloat = barWidth / 2
            let chartPoints = makeChartPoints(from: model.values, size: size, unit: model.unit, itemWidth: barWidth)
            for pathPoint in chartPoints {
                let cgPoint = pathPoint.point
                let barX = cgPoint.x
                let barY = cgPoint.y
                let barHeight = maxY(size: size) - cgPoint.y                
                let capsulePath = CGRect(x: barX-halfBarWidth, y: barY, width: barWidth, height: barHeight)
                context.fill(
                    Capsule().path(in: capsulePath),
                    with: .color(color)
                )
            }
        }
        .frame(height: graphHeight)
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            BarChart(
                graphHeight: 150,
                model: .from(rawValues: [70,30,20,50,20,80,90,180,200,30,20,10,29,300], unit: "mg", title: "Caffeine(mg)")!
            )
            .padding()
        }
    }
}

