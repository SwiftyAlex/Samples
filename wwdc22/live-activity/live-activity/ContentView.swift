//
//  ContentView.swift
//  live-activity
//
//  Created by Alex Logan on 28/07/2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var coffeeState: CoffeeDeliveryStatus = .recieved
    @State var hasPermissions: Bool = false
    @StateObject var model = CoffeeModel()

    var body: some View {
        List {
            if let activity = model.liveActivity {
                Section {
                    activityText(activityState: activity.activityState)
                    Text(coffeeState.displayText)
                    Picker(
                        "Coffee State",
                        selection: .init(get: {
                            self.coffeeState
                        }, set: {
                            self.coffeeState = $0
                            model.updateActivity(state: $0)
                        }),
                        content: {
                            ForEach(CoffeeDeliveryStatus.allCases, id: \.self) { coffeeStatus in
                                Text(coffeeStatus.displayText)
                            }
                        }
                    )
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    stopActivityButton
                }
            } else {
                Section {
                    startActivityButton
                }
            }

            if !hasPermissions {
                pushPermissionsButton
            }
        }
        .onAppear {
            updateNotificationStatus()
        }
    }

    func activityText(activityState: ActivityState) -> some View {
        let activityStatus = {
            switch activityState {
            case .active:
                return "Active"
            case .dismissed:
                return "Dismissed"
            case .ended:
                return "Ended"
            }
        }()
        return Text(activityStatus)
            .font(.body.weight(.medium))
    }

    var pushPermissionsButton: some View {
        Button(action: {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            ) { _, error in
                updateNotificationStatus()
            }
        }, label: {
            Text("Request Permissions")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 12))
        })
        .listRowInsets(EdgeInsets())
    }

    var startActivityButton: some View {
        Button(action: {
            model.start(coffeeName: "Flat White")
        }, label: {
            Text("Start Activity")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 12))
        })
        .listRowInsets(EdgeInsets())
    }

    var stopActivityButton: some View {
        Button(action: {
            model.stop()
        }, label: {
            Text("Stop Activity")
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 12))
        })
        .listRowInsets(EdgeInsets())
    }

    private func updateNotificationStatus() {
        // Check Permissions
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            self.hasPermissions = settings.authorizationStatus == .authorized
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
