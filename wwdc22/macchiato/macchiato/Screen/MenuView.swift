//
//  MenuView.swift
//  macchiato
//
//  Created by Alex Logan on 07/06/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ScrollView {
            CoffeeGrid()
        }
        .navigationTitle("Menu")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
