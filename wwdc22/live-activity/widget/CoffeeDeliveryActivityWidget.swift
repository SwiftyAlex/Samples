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
        ActivityConfiguration(attributesType: CoffeeDeliveryAttributes.self) { context in
            CoffeeDeliveryActivityWidgetView(
                attributes: context.attributes,
                state: context.state
            )
        }
    }
}

struct CoffeeDeliveryActivityWidgetView: View {
    let attributes: CoffeeDeliveryAttributes
    let state: CoffeeDeliveryAttributes.ContentState

    var stateImageName: String {
        switch state.currentStatus {
        case .recieved:
            return "cup.and.saucer.fill"
        case .preparing:
            return "person.2.badge.gearshape.fill"
        case .outForDelivery:
            return "box.truck.badge.clock.fill"
        }
    }

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
                Image(systemName: stateImageName)
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

