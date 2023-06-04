//
//  DayNine.swift
//  12 Days
//
//  Created by Alex Logan on 02/01/2023.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct DayNine: View {
    @StateObject private var model = Model()

    var body: some View {
        VStack {
            if let location = model.location?.coordinate {
                Text("Latitude: \(location.latitude.formatted()) Longitude: \(location.longitude.formatted())")
                    .foregroundColor(.primary)
            }
            // We have to use a pre-selected title
            LocationButton(.sendMyCurrentLocation, action: {
                // we have permission!
                model.update()
            })
            // Adjust the font if you'd prefer something else, weights will be ignored
            .font(.caption2)
            // Get a filled style using symbol variant
            .symbolVariant(.fill)
            // Set to iconOnly for just an icon button
            .labelStyle(.titleAndIcon)
            // Clip for custom shapes
            .clipShape(Capsule())
        }
        .foregroundColor(.white)
        // You can customise the color using `tint`
        .tint(Color.indigo)
    }
}

class Model: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func update() {
        locationManager.requestLocation()
    }
}

extension Model: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


struct DayNine_Previews: PreviewProvider {
    static var previews: some View {
        DayNine()
    }
}
