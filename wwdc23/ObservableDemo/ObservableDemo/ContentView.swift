//
//  ContentView.swift
//  ObservableDemo
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let counter: Counter

    var body: some View {
        NavigationStack {
            let _ = Self._printChanges()
            VStack {
                Text(counter.count.formatted())
                    .monospaced()

                HStack(spacing: 32) {
                    Button(action: {
                        counter.count -= 1
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                    })

                    Button(action: {
                        counter.count += 1
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })

                    Button(action: {
                        counter.string = UUID().uuidString
                    }, label: {
                        Text("Change")
                    })
                }
            }
            .font(.largeTitle)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .animation(.spring, value: counter.count)
    }
}

#Preview {
    ContentView(
        counter: Counter()
    )
}
