//
//  ContentView.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ReallyFancyCustomList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
