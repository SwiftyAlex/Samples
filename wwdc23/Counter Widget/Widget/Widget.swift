//
//  Widget.swift
//  Widget
//
//  Created by Alex Logan on 06/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: Date(), counter: 37)
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> ()) {
        completion(
            CounterEntry(date: Date(), counter: 11)
        )
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [
            CounterEntry(
                date: Date(),
                counter: UserDefaults(suiteName: Constants.suiteName)?.integer(forKey: Constants.key) ?? 0
            )
        ], policy: .never)
        completion(timeline)
    }
}

struct CounterEntry: TimelineEntry {
    let date: Date
    let counter: Int
}

struct WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.counter.formatted())
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .contentTransition(.numericText(countsDown: false))

            HStack {
                Button(intent: DecrementIntent(), label: {
                    Image(systemName: "minus.circle.fill")
                })


               Spacer()

               Button(intent: IncrementIntent(), label: {
                   Image(systemName: "plus.circle.fill")
               })
            }
            .padding()
        }
        .containerBackground(.fill.quaternary.opacity(0.1), for: .widget)
    }
}

struct CounterWidget: Widget {
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .containerBackgroundRemovable(true)
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    CounterWidget()
} timeline: {
    CounterEntry(date: .init(), counter: 12)
    CounterEntry(date: .init(), counter: 100)
    CounterEntry(date: .init(), counter: 0)
    CounterEntry(date: .init(), counter: -1)
}
