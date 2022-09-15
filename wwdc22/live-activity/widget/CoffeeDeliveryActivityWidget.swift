//
//  CoffeeDeliveryActivityWidget.swift
//  live-activity
//
//  Created by Alex Logan on 28/07/2022.
//

import Foundation
import SwiftUI
import WidgetKit
import ActivityKit

struct CoffeeDeliveryActivityWidget: Widget {
    var body: some WidgetConfiguration {
        return ActivityConfiguration(for: CoffeeDeliveryAttributes.self) { context in
            CoffeeDeliveryActivityWidgetView(
                attributes: context.attributes,
                state: context.state
            )
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.trailing, content: {
                    HStack(alignment: .center) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                            Image(systemName: context.state.stateImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .padding(12)
                        }
                        .frame(width: 44)
                    }
                    .frame(maxHeight: .infinity)
                })
                DynamicIslandExpandedRegion(.leading, priority: .greatestFiniteMagnitude, content: {
                    Text(context.state.currentStatus.longText)
                        .font(.caption.weight(.semibold))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                })
                // Alternate solution
//                DynamicIslandExpandedRegion(.center, priority: .greatestFiniteMagnitude) {
//                    HStack(alignment: .center) {
//                        Text(context.state.currentStatus.longText)
//                            .font(.caption.weight(.semibold))
//                            .lineLimit(nil)
//                            .multilineTextAlignment(.leading)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//                        ZStack {
//                            Circle()
//                                .foregroundColor(.white)
//                            Image(systemName: context.state.stateImageName)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .foregroundColor(.black)
//                                .padding(12)
//                        }
//                    }
//                }
            } compactLeading: {
                makeView(for: "figure.run")
            } compactTrailing: {
                makeView(for: context.state.stateImageName)
            } minimal: {
                makeView(for: context.state.stateImageName)
            }
        }
    }
    
    func makeView(for imageName: String) -> some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
                .padding(6)
        }
        .padding(.vertical, 6)
    }
}


extension CoffeeDeliveryAttributes.ContentState {
    var stateImageName: String {
        switch currentStatus {
        case .recieved:
            return "cup.and.saucer.fill"
        case .preparing:
            return "person.2.badge.gearshape.fill"
        case .outForDelivery:
            return "box.truck.badge.clock.fill"
        }
    }
}

struct CoffeeDeliveryActivityWidgetView: View {
    let attributes: CoffeeDeliveryAttributes
    let state: CoffeeDeliveryAttributes.ContentState

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Order")
                    .font(.subheadline.weight(.semibold))
                    .opacity(0.8)
                Text(attributes.coffeeName)
                    .font(.headline.weight(.semibold))
            }

            Spacer()

            VStack(alignment: .center, spacing: 6) {
                Image(systemName: state.stateImageName)
                    .font(.headline.weight(.bold))
                Text(state.currentStatus.displayText)
                    .font(.headline.weight(.semibold))
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.cyan)
        .activityBackgroundTint(Color.cyan)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct CoffeeDeliveryActivityWidget_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeDeliveryActivityWidgetView(attributes: .init(coffeeName: "Flat White"), state: .init(currentStatus: .recieved))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

