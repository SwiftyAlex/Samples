//
//  Seventeen_Widgets.swift
//  Seventeen Widgets
//
//  Created by Alex Logan on 08/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct Seventeen_WidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Button(intent: PlayerIntent(action: .play)) {
                Image(systemName: "play.fill")
                    .font(.subheadline.weight(.semibold))
                    .fontDesign(.rounded)
            }
            .buttonStyle(.borderedProminent)

            Button(intent: PlayerIntent(action: .pause)) {
                Image(systemName: "pause.fill")
                    .font(.subheadline.weight(.semibold))
                    .fontDesign(.rounded)
            }
            .buttonStyle(.borderedProminent)
        }
        .tint(Color.mint)
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct ControlsWidget: Widget {
    let kind: String = "Seventeen_Widgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Seventeen_WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    ControlsWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
