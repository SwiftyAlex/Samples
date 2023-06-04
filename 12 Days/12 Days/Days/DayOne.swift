//
//  DayOne.swift
//  12 Days
//
//  Created by Alex Logan on 26/12/2022.
//

import SwiftUI

struct DayOne: View {
    var body: some View {
        ViewThatFits(in: .vertical) {
            // Can we fit without scrolling?
            content

            // If not, lets whack in a scroll view!
            ScrollView {
                content
            }
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            Color(uiColor: .systemBackground).edgesIgnoringSafeArea(.all)
        )
    }

    var content: some View {
        Text(DemoData.Strings.long.rawValue)
            .font(.subheadline.weight(.medium))
            .padding()
    }
}

struct DayOne_Previews: PreviewProvider {
    static var previews: some View {
        DayOne()
    }
}
