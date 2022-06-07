//
//  ContentView.swift
//  plot
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import Charts


struct Run: Identifiable, Hashable {
    var id = UUID()
    var distanceKm: Double
    var sleepHours: Double = Double.random(in: 0..<8)
    var day: String
}

struct ContentView: View {
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
        NavigationStack {
            WeeklyChartsView()
                .navigationTitle(Text("Run Book"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
