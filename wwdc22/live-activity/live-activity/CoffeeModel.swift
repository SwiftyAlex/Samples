//
//  CoffeeModel.swift
//  live-activity
//
//  Created by Alex Logan on 28/07/2022.
//

import Foundation
import ActivityKit

class CoffeeModel: ObservableObject {
    @Published var liveActivity: Activity<CoffeeDeliveryAttributes>?
    @Published var secondActivity: Activity<CoffeeDeliveryAttributes>?

    func start(coffeeName: String, isSecond: Bool = false) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Activities are not enabled.")
            return
        }
        Task {
            let attributes = CoffeeDeliveryAttributes(coffeeName: coffeeName)
            let state = CoffeeDeliveryAttributes.ContentState(currentStatus: .recieved)
            do {
                try await MainActor.run {
                    let activity = try Activity<CoffeeDeliveryAttributes>.request(
                        attributes: attributes,
                        contentState: state,
                        pushType: nil
                    )
                    if isSecond {
                        secondActivity = activity
                    } else {
                        liveActivity = activity
                    }
                }
                print("Started activity")
            } catch (let error) {
                print("Error starting activity \(error) \(error.localizedDescription)")
            }
        }
    }

    func updateActivity(state: CoffeeDeliveryStatus) {
        let state = CoffeeDeliveryAttributes.ContentState(currentStatus: state)
        Task {
            await liveActivity?.update(using: state)
        }
    }

    func stop() {
        Task {
            await liveActivity?.end(using: nil, dismissalPolicy: .immediate)
            await MainActor.run {
                liveActivity = nil
            }
        }
    }

    func stopSecond() {
        Task {
            await secondActivity?.end(using: nil, dismissalPolicy: .immediate)
            await MainActor.run {
                secondActivity = nil
            }
        }
    }
}
