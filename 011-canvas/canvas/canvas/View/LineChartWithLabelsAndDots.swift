//
//  LineChartWithLabelsAndDots.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import SwiftUI

struct LineChartWithLabelsAndDots: ChartView {
    let insets: CGFloat = 8
    let strokeWidth: CGFloat = 6
    var color: Color = .teal
    let graphHeight: CGFloat
    let dotWidth: CGFloat = 8
    
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
            var path = Path()
            let chartPoints = makeChartPoints(from: model.values, size: size, unit: model.unit)
            for pathPoint in chartPoints {
                if path.isEmpty {
                    path.move(to: pathPoint.point)
                } else {
                    path.addLine(to: pathPoint.point)
                }
                let circleBox = CGRect(x: pathPoint.point.x - (dotWidth/2), y: pathPoint.point.y - (dotWidth/2), width: dotWidth, height: dotWidth)
                context.fill(Circle().path(in: circleBox), with: .color(color))
            }
            context.stroke(
                path,
                with: .color(color.opacity(0.5)),
                style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round)
            )
        }
        .frame(height: graphHeight)
    }
}

struct LineChartWithLabelsAndDots_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            LineChartWithLabelsAndDots(
                graphHeight: 150,
                model: .from(rawValues: [42,12,32,0,70], unit: "mg", title: "Caffeine(mg)")!
            )
            .padding()
        }
    }
}
