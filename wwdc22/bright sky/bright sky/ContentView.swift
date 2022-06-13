//
//  ContentView.swift
//  bright sky
//
//  Created by Alex Logan on 10/06/2022.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import WeatherKit

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State var weather: Weather?

    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).edgesIgnoringSafeArea(.all)
            content
                .onChange(of: viewModel.location) { newLocation in
                    if let newLocation {
                        Task {
                            await fetchWeather(location: newLocation)
                        }
                    }
                }
                .animation(.spring(), value: weather)
        }
    }

    var content: some View {
        VStack {
            if viewModel.location == nil {
                LocationButton(.currentLocation) {
                    viewModel.requestLocation()
                }
                .foregroundColor(.white)
                .symbolVariant(.fill)
                .labelStyle(.titleAndIcon)
                .clipShape(Capsule())
                .transition(.opacity)
            } else if let weather {
                WeatherButton(weather: weather)
                    .transition(.opacity)
            }
        }
    }

    func fetchWeather(location: CLLocation) async {
        do {
            let weather = try await WeatherService.shared.weather(for: location)
            self.weather = weather
        } catch {
            print("oops \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewModel: NSObject, ObservableObject {
    @Published var location: CLLocation?

    let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}

extension ViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
