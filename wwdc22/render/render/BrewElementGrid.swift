//
//  BrewElementGrid.swift
//  render
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct BrewElementGrid: View {
    let gridItems: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 100), spacing: 12, alignment: .topLeading), count: 2)

    var body: some View {
        LazyVGrid(columns: gridItems, alignment: .leading, spacing: 12) {
            BrewElementView(iconName: "scalemass.fill", text: "Coffee", bodyText: "13g")
            BrewElementView(iconName: "drop.fill", text: "Water", bodyText: "220g")
            BrewElementView(iconName: "divide.circle.fill", text: "Ratio", bodyText: "1:16.92")
            BrewElementView(iconName: "divide.circle.fill", text: "Ratio", bodyText: "1:16.92")
            BrewElementView(iconName: "clock.fill", text: "Bloom time", bodyText: "40 sec")
            BrewElementView(iconName: "scalemass", text: "Bloom amount", bodyText: "40g")
            BrewElementView(iconName: "hourglass", text: "Brew time", bodyText: "155sec")
        }
    }
}

struct BrewElementGrid_Previews: PreviewProvider {
    static var previews: some View {
        BrewElementGrid()
    }
}
