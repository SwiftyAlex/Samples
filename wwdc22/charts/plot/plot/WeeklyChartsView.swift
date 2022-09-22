//
//  WeeklyChartsView.swift
//  plot
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import Charts

struct WeeklyChartsView: View {
    // You could ( and should ) store this more elegantly
    @State var data: [Run] = [
        .init(distanceKm: 12.5, day: "Monday", color: .teal),
        .init(distanceKm: 6.7, day: "Tuesday", color: .pink),
        .init(distanceKm: 0, day: "Wednesday", color: .yellow),
        .init(distanceKm: 21.2, day: "Thursday", color: .green),
        .init(distanceKm: 10.4, day: "Friday", color: .red),
        .init(distanceKm: 4.3, day: "Saturday", color: .brown),
        .init(distanceKm: 36.5, day: "Sunday", color: .black),
    ]

    @State var dataTwo: [Run] = [
        .init(distanceKm: Double.random(in: 0..<40), day: "Monday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Tuesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Wednesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Thursday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Friday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Saturday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Sunday"),
    ]

    @State var dataThree: [Run] = [
        .init(distanceKm: Double.random(in: 0..<40), day: "Monday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Tuesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Wednesday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Thursday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Friday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Saturday"),
        .init(distanceKm: Double.random(in: 0..<40), day: "Sunday"),
    ]


    var body: some View {
        NavigationStack {
            List {
                Section {
                    barChart
                        .animation(.spring(), value: data)
                }
                Section {
                    lineChart
                        .animation(.spring(), value: dataTwo)
                }
                Section {
                    otherChart
                        .animation(.spring(), value: dataThree)
                }
            }
            .navigationBarItems(trailing:
                Button {
                    data.indices.forEach { index in
                        data[index].distanceKm = Double.random(in: 0..<40)
                    }
                    dataTwo.indices.forEach { index in
                        dataTwo[index].distanceKm = Double.random(in: 0..<40)
                    }
                    dataThree.indices.forEach { index in
                        dataThree[index].distanceKm = Double.random(in: 0..<40)
                    }
                } label: {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.subheadline.weight(.bold))
                }
            )
            .navigationTitle("Charts")
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
                    .foregroundStyle(run.color.gradient)
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
                ForEach(dataTwo) { (run) in
                    LineMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.blue, .teal],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
            .frame(height: 200)
        }
    }

    var otherChart: some View {
        VStack(alignment: .leading) {
            Text("Areas")
                .font(.subheadline.weight(.semibold))
            Chart {
                ForEach(dataThree) { (run) in
                    AreaMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.blue, .teal],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
            .frame(height: 200)
        }
    }
}

struct WeeklyChartsView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyChartsView()
    }
}
