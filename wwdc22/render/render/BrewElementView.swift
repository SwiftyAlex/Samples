//
//  BrewElementView.swift
//  render
//
//  Created by Alex Logan on 08/06/2022.
//

import SwiftUI

struct BrewElementView: View {
    let iconName: String
    let text: String
    let bodyText: String

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: iconName)
                .foregroundColor(.primary)
                .aspectRatio(contentMode: .fill)
                .frame(width: 22, height: 22, alignment: .center)
            VStack(alignment: .leading) {
                Text(text)
                    .font(.caption.weight(.medium))
                    .foregroundColor(.primary)
                Text(bodyText)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.primary)
            }
        }
    }
}

struct BrewElementView_Previews: PreviewProvider {
    static var previews: some View {
        BrewElementView(iconName: "scalemass.fill", text: "Water Amount", bodyText: "300ml")
    }
}
