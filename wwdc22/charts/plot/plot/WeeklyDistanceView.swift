//
//  WeeklyDistanceView.swift
//  plot
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import Charts

struct WeeklyDistanceView: View {
    @State var data: [Run] = [
        .init(distanceKm: 12.5, day: "Monday"),
        .init(distanceKm: 6.7, day: "Tuesday"),
        .init(distanceKm: 0, day: "Wednesday"),
        .init(distanceKm: 21.2, day: "Thursday"),
        .init(distanceKm: 10.4, day: "Friday"),
        .init(distanceKm: 4.3, day: "Saturday"),
        .init(distanceKm: 36.5, day: "Sunday"),
    ]
    
    var body: some View {
        Chart {
            ForEach(data) { (run) in
                BarMark(
                    x: .value("Date", run.day),
                    y: .value("Distance", run.distanceKm)
                )
                .foregroundStyle(.pink)
            }
            ForEach(data) { run in
                BarMark(
                    x: .value("Date", run.day),
                    y: .value("Distance", run.sleepHours)
                )
                .foregroundStyle(.blue.opacity(0.5))
            }
        }
        .frame(height: 200)
    }
}

struct WeeklyDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyDistanceView()
    }
}
