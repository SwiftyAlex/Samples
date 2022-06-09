//
//  widgets.swift
//  widgets
//
//  Created by Alex Logan on 09/06/2022.
//

import WidgetKit
import SwiftUI
import Intents

struct EventTimelineProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> EventEntry {
        EventEntry(date: Date(), event: .newYork)
    }

    func getSnapshot(for configuration: WidgetEventIntent, in context: Context, completion: @escaping (EventEntry) -> ()) {
        let entry = EventEntry(date: Date(), event: .newYork)
        completion(entry)
    }

    func getTimeline(for configuration: WidgetEventIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        guard
            let event = Storage.compressedEvent(for: configuration.event) else {
            completion(Timeline(entries: [EventEntry(date: Date(), event: nil)], policy: .atEnd))
            return
        }
        var dayComponents = DateComponents()
        dayComponents.day = 1
        let refreshDate = Calendar.autoupdatingCurrent.date(byAdding: dayComponents, to: Date())
        let entry = EventEntry(date: refreshDate ?? event.date, event: event)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

private extension Storage {
    // We have to compress our events as these images could be really quite large and we don't want to choke the memory of the device.
    static func compressedEvent(for siriEvent: SiriEvent?) -> Event? {
        guard let existingEvent = shared.events.first(where: { $0.id.uuidString == siriEvent?.identifier }) else { return nil }

        guard let image = UIImage(data: existingEvent.imageData) else {
            return nil
        }
        return Event(id: existingEvent.id, name: existingEvent.name, date: existingEvent.date, imageData: image.jpegData(compressionQuality: 0.5) ?? existingEvent.imageData)
    }
}

struct EventEntry: TimelineEntry {
    let date: Date
    let event: Event?
}

struct EventWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: EventTimelineProvider.Entry

    var body: some View {

        VStack(alignment: .leading) {
            if let event = entry.event {
                eventView(event: event)
            } else {
                Text("Select an event.")
                    .font(.subheadline.weight(.semibold))
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color(uiColor: .systemBackground))
    }

    func eventView(event: Event) -> some View {
        VStack {
            eventImage(imageData: event.imageData)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            EventViewText(event: event)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .bottom], 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    func eventImage(imageData: Data) -> some View {
        if let uiImage = UIImage(data: imageData) {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .clipped()
        } else {
            Rectangle()
                .foregroundStyle(Color.accentColor.gradient)
        }
    }
}

struct EventLockWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: EventTimelineProvider.Entry

    var fallbackEvent: Event? {
        Storage.shared.events.sorted(by: { $0.date < $1.date }).first
    }

    var body: some View {
        VStack {
            if let event = entry.event ?? fallbackEvent {
                widgetView(for: event)
                    .privacySensitive()
            } else {
                Image(systemName: "pencil.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }

    @ViewBuilder
    func widgetView(for event: Event) -> some View {
        switch family {
        case .accessoryRectangular:
           rectangularView(event: event)
        case .accessoryCircular:
            smallView(event: event)
        case .accessoryInline:
            inlineView(event: event)
        default:
            Text("unsupported family.")
        }
    }

    func rectangularView(event: Event) -> some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.primary)
                Text(event.date, style: .relative)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .widgetAccentable()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    func smallView(event: Event) -> some View {
        ZStack {
            AccessoryWidgetBackground()
            VStack(alignment: .center) {
                Text("\(Calendar.autoupdatingCurrent.numberOfDaysBetween(Date(), and: event.date))")
                    .font(.headline.weight(.bold))
                    .foregroundStyle(.primary)
                    .widgetAccentable()
                Text("Days")
                    .font(.subheadline.weight(.regular))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    func inlineView(event: Event) -> some View {
        Text("\(Calendar.autoupdatingCurrent.numberOfDaysBetween(Date(), and: event.date)) Days until \(event.name)")
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day!
    }
}

struct EventWidgetView: View {
    @Environment(\.widgetFamily) var family

    var entry: EventTimelineProvider.Entry

    var body: some View {
        widgetView(entry: entry)
    }

    @ViewBuilder
    func widgetView(entry: EventEntry) -> some View {
        switch family {
        case .accessoryInline, .accessoryRectangular, .accessoryCircular:
            EventLockWidgetEntryView(entry: entry)
        case .systemLarge, .systemMedium, .systemSmall:
            EventWidgetEntryView(entry: entry)
        default:
            Text("Unknown family \(family.description)")
        }
    }
}

@main
struct EventWidget: Widget {
    let kind: String = "widgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: WidgetEventIntent.self, provider: EventTimelineProvider()) { entry in
            EventWidgetView(entry: entry)
                .widgetURL(URL(string: "up-next://home?eventId=\(entry.event?.id.uuidString ?? "")"))
        }
        .configurationDisplayName("My event")
        .description("See your event on the home screen.")
        .supportedFamilies([
            .systemSmall, .systemMedium, .systemLarge,
            .accessoryInline, .accessoryRectangular, .accessoryCircular
        ])
    }
}

struct widgets_Previews: PreviewProvider {
    static var previews: some View {
        EventWidgetView(entry: EventEntry(date: Date(), event: .newYork))
                .previewContext(WidgetPreviewContext(family: .accessoryCircular))
    }
}
