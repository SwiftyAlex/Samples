//
//  CounterWidget.swift
//  widgetExtension
//
//  Created by Alex Logan on 15/09/2022.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct CounterWidget: Widget {
    var body: some WidgetConfiguration {
        return ActivityConfiguration(for: CounterActivityAttributes.self) { context in
            Text(context.state.count.formatted())
                .foregroundStyle(.cyan.gradient)
        } dynamicIsland: { context in
            DynamicIsland(expanded: {
                DynamicIslandExpandedRegion(.center) {
                    Text(context.state.count.formatted())
                        .foregroundStyle(.cyan.gradient)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let url = nextURL {
                        VStack {
                            Link(destination: url) {
                                Image(systemName: "chevron.up.circle.fill")
                                    .font(.title2.weight(.semibold))
                                    .foregroundStyle(.white.gradient)
                            }
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                }
            }, compactLeading: {
                if let url = nextURL {
                    Link(destination: url) {
                        Image(systemName: "chevron.up.circle.fill")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.white.gradient)
                            .widgetURL(url)
                    }
                } else {
                    Image(systemName: "chevron.up.circle.fill")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.white.gradient)
                }
            }, compactTrailing: {
                Text(context.state.count.formatted())
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.gradient)
            }, minimal: {
                Text(context.state.count.formatted())
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.gradient)
            })
            .keylineTint(.cyan) // Currently doesn't appear to work
            .widgetURL(nextURL)
        }
    }
    
    var nextURL: URL? {
        return URL(string: "live-activity-sample://action/next")
    }
}
