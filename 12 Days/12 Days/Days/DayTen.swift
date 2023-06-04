//
//  DayTen.swift
//  12 Days
//
//  Created by Alex Logan on 02/01/2023.
//

import SwiftUI

struct DayTen: View {
    // This view is bound to a string somewhere else
    var text: Binding<String>

    var body: some View {
        List {
            Section {
                TextField(text: text, label: {
                    Text("What's your name?")
                })
            }
            Section {
                Text("Hey ")
                + Text(text.wrappedValue)
                    .fontWeight(.bold)
                + Text(" 👋🏻")
            }
        }
    }
}

struct DayTen_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }

    // Create a micro-wrapper around your view
    // This can have anything a normal view can!
    private struct Preview: View {
        @State var text: String = "Alex"

        var body: some View {
            // You can wrap in navigation if you're testing insets etc
            NavigationView {
                DayTen(text: $text)
                    .navigationTitle("Day Ten")
            }
        }
    }
}
