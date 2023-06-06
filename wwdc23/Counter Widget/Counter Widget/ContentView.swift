//
//  ContentView.swift
//  Counter Widget
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(
        Constants.key,
        store: UserDefaults(suiteName: Constants.suiteName) ?? .standard
    ) var counter: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                Text(counter.formatted())

                HStack(spacing: 32) {
                    Button(action: {
                        counter = counter - 1
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                    })

                    Button(action: {
                        counter = counter + 1
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })

                }
            }
            .font(.largeTitle)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    ContentView()
}
