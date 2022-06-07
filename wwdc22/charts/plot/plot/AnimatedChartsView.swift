//
//  AnimatedChartsView.swift
//  plot
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import Charts

struct AnimatedChartsView: View {
    @State var data: [Run] = [
        .init(distanceKm: 12.5, day: "Monday"),
        .init(distanceKm: 6.7, day: "Tuesday"),
        .init(distanceKm: 0, day: "Wednesday"),
        .init(distanceKm: 21.2, day: "Thursday"),
        .init(distanceKm: 10.4, day: "Friday"),
        .init(distanceKm: 4.3, day: "Saturday")
    ]

    var body: some View {
        VStack {
            Chart {
                ForEach(data) { (run) in
                    BarMark(
                        x: .value("Date", run.day),
                        y: .value("Distance", run.distanceKm)
                    )
                    .foregroundStyle(.pink)
                }
            }
            .animation(.spring(), value: data)
            .frame(height: 200)
            Button(action: {
                data.append(.init(distanceKm: Double.random(in: 0..<40), day: "Sunday"))
            }) {
                Label("Add your run", systemImage: "plus")
            }
        }
    }
}

struct AnimatedChartsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedChartsView()
    }
}
