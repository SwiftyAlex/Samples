//
//  MenuView.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI
import AppIntents

struct MenuView: View {
    var body: some View {
        ScrollView {
            CoffeeGrid()
            SiriTipView(
                intent: OpenMenuIntent()
            )
            .padding()
            .siriTipViewStyle(.dark)
        }
        .navigationTitle("Menu")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
