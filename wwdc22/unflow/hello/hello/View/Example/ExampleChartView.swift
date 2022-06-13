//
//  ExampleChartView.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI
import Charts

struct ExampleChartView: View {
    @State var data: [Run] = Run.randomisedWeek

    var body: some View {
        NavigationStack {
            List {
                Section { barChart }
                Section { lineChart }
                Section { areaChart }
                Section { pointChart }
            }
        }
    }

    var barChart: some View {
        VStack(alignment: .leading) {
            Text("Bars")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(data) { (run) in
                    BarMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.teal.gradient)
                }
            }
            .frame(height: 200)
        }
    }

    var lineChart: some View {
        VStack(alignment: .leading) {
            Text("Lines")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(data) { (run) in
                    LineMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.blue.gradient)
                }
            }
            .frame(height: 200)
        }
    }

    var areaChart: some View {
        VStack(alignment: .leading) {
            Text("Areas")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(data) { (run) in
                    AreaMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.yellow.gradient)
                }
            }
            .frame(height: 200)
        }
    }

    var pointChart: some View {
        VStack(alignment: .leading) {
            Text("Points")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(data) { (run) in
                    PointMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.gray.gradient)
                }
            }
            .frame(height: 200)
        }
    }

    var rectMark: some View {
        VStack(alignment: .leading) {
            Text("Rectangles")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(data) { (run) in
                    RectangleMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.green.gradient)
                }
            }
            .frame(height: 200)
        }
    }
}

struct ExampleChartView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleChartView()
    }
}
