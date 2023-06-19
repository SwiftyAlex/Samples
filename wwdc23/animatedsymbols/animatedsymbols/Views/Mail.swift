//
//  Mail.swift
//  animatedsymbols
//
//  Created by Alex Logan on 19/06/2023.
//

import SwiftUI

struct Mail: View {
    @State var gotMail: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "mail")
                .foregroundColor(gotMail ? .cyan : .gray)
                .animation(.linear, value: gotMail)
                .font(.largeTitle)
                .fontDesign(.rounded)
                .symbolEffect(.pulse.wholeSymbol, isActive: gotMail)

            Button(action: {
                gotMail.toggle()
            }, label: {
                Text("Toggle")
                    .font(.headline.weight(.semibold))
                    .fontDesign(.rounded)
            })
            .foregroundColor(.cyan)
        }
    }
}

#Preview {
    Mail()
}
