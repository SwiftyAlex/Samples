//
//  DayEight.swift
//  12 Days
//
//  Created by Alex Logan on 30/12/2022.
//

import SwiftUI

struct DayEight: View {
    var body: some View {
        VStack {
            ButtonComparison(color: .red)
            ButtonComparison(color: .orange)
            ButtonComparison(color: .yellow)
            ButtonComparison(color: .green)
            ButtonComparison(color: .blue)
            ButtonComparison(color: .indigo)
        }
    }
}

private struct ButtonComparison: View {
    let color: Color

    var body: some View {
        HStack {
            Button(action: { }, label: {
                Text("basic")
                    .foregroundColor(.white)
                    .padding()
                    .background(color, in: RoundedRectangle(cornerRadius: 8))
            })
            Button(action: { }, label: {
                Text("nice")
                    .foregroundColor(.white)
                    .padding()
                    .background(color.gradient, in: RoundedRectangle(cornerRadius: 8))
            })
            Text("Works on text too!")
                .foregroundStyle(color.gradient)
        }
        .font(.headline.weight(.semibold))
    }
}

struct DayEight_Previews: PreviewProvider {
    static var previews: some View {
        DayEight()
    }
}
