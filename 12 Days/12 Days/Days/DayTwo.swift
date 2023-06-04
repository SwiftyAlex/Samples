//
//  DayTwo.swift
//  12 Days
//
//  Created by Alex Logan on 26/12/2022.
//

import SwiftUI

struct DayTwo: View {
    var body: some View {
        VStack {
            WrappingGeometryReader { height in
                Text("I'm \(height.formatted()) pixels tall!")
            }
            Text("Please don't push me off the screen 😱")
        }
    }
}

struct WrappingGeometryReader<Content: View>: View {
    @State var height: CGFloat = UIFont.labelFontSize // Generic non zero height

    let content: (CGFloat) -> Content // Content is provided with the height

    init(@ViewBuilder content: @escaping (CGFloat) -> Content) {
        self.content = content
    }

    var body: some View {
        content(height)
            .fixedSize(horizontal: false, vertical: true)
            .background {
                // Use the background to not fiddle with the size with our reader
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: HeightKey.self, value: geometry.frame(in: .global).height)

                }
            }
            .onPreferenceChange(HeightKey.self, perform: { keyHeight in
                height = keyHeight
            })
            .frame(maxHeight: height)
    }
}

private struct HeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct DayTwo_Previews: PreviewProvider {
    static var previews: some View {
        DayTwo()
    }
}
