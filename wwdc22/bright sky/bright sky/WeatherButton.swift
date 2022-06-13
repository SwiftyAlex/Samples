//
//  WeatherButton.swift
//  bright sky
//
//  Created by Alex Logan on 10/06/2022.
//

import SwiftUI
import WeatherKit

struct WeatherButton: View {
    let weather: Weather

    var body: some View {
        HStack {
            Image(systemName: weather.currentWeather.symbolName)
            Text(weather.currentWeather.temperature.formatted())
        }
        .font(.subheadline.weight(.semibold))
        .padding()
        .background(
            Capsule()
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.5), radius: 8)
        )
    }
}
