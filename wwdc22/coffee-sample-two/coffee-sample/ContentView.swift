//
//  ContentView.swift
//  coffee-sample
//
//  Created by Alex Logan on 06/06/2022.
//

import SwiftUI

struct Coffee: Equatable, Hashable {
    let name: String
}

struct ContentView: View {
    @State private var path = NavigationPath()
    @State private var coffees = [ Coffee(name: "Flat White"), Coffee(name: "Cortado"), Coffee(name: "Mocha") ]

    var body: some View {
        // iPad example
        //SplitExampleView()
        // Fancy iPad Example
        FancySplitExampleView()
        // Deeplink example
        // DeeplinkView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
