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
            
            // Second Activity

            Section {
                if model.secondActivity != nil {
                    stopSecondActivityButton
                } else {
                    startSecondActivityButton
                }
            }
            
            // Counter
            Section {
                if model.counterActivity == nil {
                    startCounterActivityButton
                } else {
                    if let counter = model.currentCount {
                        Text(counter.formatted())
                            .font(.subheadline.weight(.semibold))
                    }
                    stopCounterActivityButton
                }
            }

            // Permissions
            if !hasPermissions {
                pushPermissionsButton
            }
        }
        .onAppear {
            updateNotificationStatus()
        }
        .onOpenURL { url in
            print(url)
            if url.pathComponents.last == "next" {
                self.model.increment()
            }
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
            makeButtonLabel("Request Permissions")
        })
        .listRowInsets(EdgeInsets())
    }

    var startActivityButton: some View {
        Button(action: {
            model.start(coffeeName: "Flat White")
        }, label: {
            makeButtonLabel("Start activity")
        })
        .listRowInsets(EdgeInsets())
    }
    
    var startSecondActivityButton: some View {
        Button(action: {
            model.start(coffeeName: "Flat White", isSecond: true)
        }, label: {
            makeButtonLabel("Start second activity")
        })
        .listRowInsets(EdgeInsets())
    }
    
    var startCounterActivityButton: some View {
        Button(action: {
            model.startCounter()
        }, label: {
            makeButtonLabel("Start interactive activity")
        })
        .listRowInsets(EdgeInsets())
    }

    var stopActivityButton: some View {
        Button(action: {
            model.stop()
        }, label: {
            makeButtonLabel("Stop Activity")
        })
        .listRowInsets(EdgeInsets())
    }
    
    var stopSecondActivityButton: some View {
        Button(action: {
            model.stopSecond()
        }, label: {
            makeButtonLabel("Stop second Activity")
        })
        .listRowInsets(EdgeInsets())
    }
    
    var stopCounterActivityButton: some View {
        Button(action: {
            model.stopCounter()
        }, label: {
            makeButtonLabel("Stop Counter")
        })
        .listRowInsets(EdgeInsets())
    }
    
    private func makeButtonLabel(_ text: String) -> some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 12))
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
