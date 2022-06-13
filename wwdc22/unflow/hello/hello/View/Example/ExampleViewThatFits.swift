//
//  ExampleViewThatFits.swift
//  hello
//
//  Created by Alex Logan on 13/06/2022.
//

import SwiftUI

struct ExampleViewThatFits: View {
    var body: some View {
        VStack(spacing: 0) {
            content
            content
                .frame(maxHeight: 30)
            content
                .frame(maxHeight: 20)
        }
    }

    var content: some View {
        ViewThatFits {
            Text("Hello, World!")
                .font(.largeTitle.weight(.semibold))
            Text("Hello, World!")
                .font(.headline.weight(.semibold))
            Text("hey world")
                .font(.subheadline.weight(.semibold))
        }
    }
}

struct ExampleViewThatFits_Previews: PreviewProvider {
    static var previews: some View {
        ExampleViewThatFits()
    }
}
