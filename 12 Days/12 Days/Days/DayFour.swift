//
//  DayFour.swift
//  12 Days
//
//  Created by Alex Logan on 28/12/2022.
//

import SwiftUI

struct DayFour: View {
    @State var sharedText: String = "Blank Space"
    let desiredMaxLines: Int = 6

    var body: some View {
        List {
            Section("TextField") {
                // TextField and TextEditor won't respect line limits.
                // TextField is one line, TextEditor is unlimited*
                TextField("Name", text: $sharedText)
            }

            // For TextEditor, approximatley set the size using the font.
            Section("TextEditor") {
                TextEditor(text: $sharedText)
                    .font(.subheadline)
                    .frame(
                        height: UIFont.preferredFont(forTextStyle: .subheadline).lineHeight * CGFloat(desiredMaxLines)
                    )
            }

            Section("Text") {
                // Text will take the limit
                // And optionally reserve space
                Text(sharedText)
                    .lineLimit(desiredMaxLines, reservesSpace: true)
            }

            Section("Text with no minimum") {
                // If you just have a max, set the range like so
                Text(sharedText)
                    .lineLimit(...desiredMaxLines)
            }
        }
    }
}

struct DayFour_Previews: PreviewProvider {
    static var previews: some View {
        DayFour()
    }
}
