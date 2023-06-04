//
//  CheekyBonusTip.swift
//  12 Days
//
//  Created by Alex Logan on 05/01/2023.
//

import SwiftUI

struct CheekyBonusTip: View {
    // Use this as a multiple
    @ScaledMetric var scale: CGFloat = 1
    // If you're just scaling one number, scale directly
    @ScaledMetric var boxSize: CGFloat = 44
    // Scale alongside a font size to match nicely
    @ScaledMetric(relativeTo: .largeTitle) var titleScale: CGFloat = 1

    var body: some View {
        VStack {
            Text("Scale")
            Text(scale.formatted())
            Rectangle()
                .foregroundColor(.teal)
                .frame(width: boxSize, height: boxSize)

            Text("Relative Scale")
            Text(titleScale.formatted())
                .foregroundColor(.secondary)

            Rectangle()
                .foregroundColor(.cyan)
                .frame(width: 44*titleScale, height: 44*titleScale)
        }
        .font(.largeTitle.weight(.semibold))
    }
    
}

struct CheekyBonusTip_Previews: PreviewProvider {
    static var previews: some View {
        CheekyBonusTip()
    }
}

