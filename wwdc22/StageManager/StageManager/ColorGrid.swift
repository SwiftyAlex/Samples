//
//  ColorGrid.swift
//  StageManager
//
//  Created by Alex Logan on 18/10/2022.
//

import SwiftUI

struct ColorGrid: View {
    var gridItems: [GridItem] {
        return [GridItem.init(.adaptive(minimum: 150))]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(AppColor.allCases, id: \.self) { color in
                    ColorView(color: color)
                }
            }
            .padding()
        }
    }
}

private struct ColorView: View {
    var color: AppColor

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundColor(color.color)
            .aspectRatio(1.0, contentMode: .fit)
    }
}

struct ColorGrid_Previews: PreviewProvider {
    static var previews: some View {
        ColorGrid()
    }
}
