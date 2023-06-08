//
//  Run_Widget.swift
//  Run Widget
//
//  Created by Alex Logan on 08/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DistanceEntry {
        DistanceEntry(date: Date(), distance: 37.7)
    }

    func getSnapshot(in context: Context, completion: @escaping (DistanceEntry) -> ()) {
        completion(
            DistanceEntry(date: Date(), distance: 37.7)
        )
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DistanceEntry>) -> ()) {
        Task {
            completion(
                Timeline(entries: [.init(date: Date(), distance: await RunStore().currentDistance())], policy: .after(Date().addingTimeInterval(86400)))
            )
        }
    }
}

struct DistanceEntry: TimelineEntry {
    let date: Date
    let distance: Double
}

struct Run_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.distance.formatted(.number))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.mint.gradient)
            Text("km")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(Color.mint.gradient)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct Run_Widget: Widget {
    let kind: String = "Run_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Run_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Distance")
        .description("See your distance for this week.")
    }
}

#Preview(as: .systemSmall) {
    Run_Widget()
} timeline: {
    DistanceEntry(date: .init(), distance: 37.7)
}
