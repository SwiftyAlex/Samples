//
//  TrackRun_Widget.swift
//  Run Tracker
//
//  Created by Alex Logan on 08/06/2023.
//

import WidgetKit
import SwiftUI

struct IntentProvider: AppIntentTimelineProvider {
    typealias Entry = TrackingDistanceEntry
    typealias Intent = RunIntent

    func snapshot(for configuration: RunIntent, in context: Context) async -> TrackingDistanceEntry {
        return .init(date: Date(), run: .ten, distance: 37.7)
    }

    func placeholder(in context: Context) -> TrackingDistanceEntry {
        return .init(date: Date(), run: .ten, distance: 37.7)
    }

    func timeline(for configuration: RunIntent, in context: Context) async -> Timeline<TrackingDistanceEntry> {
        return Timeline(entries: [.init(date: Date(), run: configuration.run, distance: await RunStore().currentDistance())], policy: .never)
    }
}

struct TrackingDistanceEntry: TimelineEntry {
    let date: Date
    let run: CommonRun
    let distance: Double
}

struct TrackRun_WidgetRun_WidgetEntryView : View {
    var entry: IntentProvider.Entry

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(entry.distance.formatted(.number))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.mint.gradient)
                    .monospacedDigit()
                Text("km")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.mint.gradient)
            }

            Button(intent: RunIntent(run: entry.run), label: {
                Text("Track \(entry.run.rawValue.formatted())km")
                    .font(.subheadline.weight(.bold))
                    .fontDesign(.rounded)
            })
            .buttonStyle(.borderedProminent)
            .tint(Color.mint)
        }
        .fontDesign(.rounded)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct TrackRun_Widget: Widget {
    let kind: String = "TrackRun_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: RunIntent.self, provider: IntentProvider()) { entry in
            TrackRun_WidgetRun_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Track your run")
        .description("Pick a distance, tap to track.")
    }
}

#Preview(as: .systemSmall) {
    TrackRun_Widget()
} timeline: {
    TrackingDistanceEntry(date: .init(), run: .ten, distance: 37.7)
    TrackingDistanceEntry(date: .init(), run: .halfMarathon, distance: 37.7)
}
