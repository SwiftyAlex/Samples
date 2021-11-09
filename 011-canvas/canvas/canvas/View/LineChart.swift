//
//  LineChart.swift
//  canvas
//
//  Created by Alex Logan on 08/11/2021.
//

import SwiftUI

struct LineChart: ChartView {
    let insets: CGFloat = 8
    let strokeWidth: CGFloat = 6
    var color: Color = .teal
    let graphHeight: CGFloat
    var model: ChartModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.subheadline)
                .fontWeight(.semibold)
            Canvas { context, size in
                var path = Path()
                let chartPoints = makeChartPoints(from: model.values, size: size, unit: model.unit)
                for pathPoint in chartPoints {
                    if path.isEmpty {
                        path.move(to: pathPoint.point)
                    } else {
                        path.addLine(to: pathPoint.point)
                    }
                }
                context.stroke(
                    path,
                    with: .color(color),
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round)
                )
            }
            .frame(height: graphHeight)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(UIColor.systemBackground))
        )
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
            LineChart(
                graphHeight: 180,
                model: .from(rawValues: [42,12,32,0,70], unit: "mg", title: "Caffeine(mg)")!
            )
            .frame(height: 200)
            .padding()
        }
    }
}
