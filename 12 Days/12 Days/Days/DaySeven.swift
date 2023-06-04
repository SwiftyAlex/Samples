//
//  DaySeven.swift
//  12 Days
//
//  Created by Alex Logan on 30/12/2022.
//

import SwiftUI

struct DaySeven: View {
    var body: some View {
        ZStack {
            Color(UIColor.darkGray).edgesIgnoringSafeArea(.all)
            List {
                Section {
                    // You can clear the insets & the background to let a view do whatever it wants
                    // This works on a per item basis too!
                    // Remember when you do this you need to pad your own content.
                    Text("I'm just floating out here 👀")
                        .modifier(ListRowStyleClearedModifier())
                        .padding()
                    Text("me too!")
                        .modifier(ListRowStyleClearedModifier())
                        .padding()
                }
                // Some list styles have sidebar seperators - which you can hide
                .listSectionSeparator(.hidden)

                Section {
                    Text("One")
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        // Override our tint and make it white, only if this is below
                        .listRowSeparatorTint(.white, edges: .bottom)
                        // Hide if its a top seperator
                        .listRowSeparator(.hidden, edges: .top)
                        .padding()
                     Text("Two")
                        .foregroundStyle(.white.gradient)
                        .modifier(ListRowStyleClearedModifier())
                        .padding()

                }
            }
            .font(.body.weight(.semibold))
            .foregroundStyle(.white.gradient)
            // Use a plain view to get the simplest starting point
            .listStyle(.plain)
            // Remove the in-built backgrounds
            .scrollContentBackground(.hidden)
            // Hide the keyboard as soon as you scroll - no interspection needed!
            .scrollDismissesKeyboard(.interactively)
            // Apply .searchable & .refreshable for full list functionality
        }
    }
}

struct ListRowStyleClearedModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }
}

struct DaySeven_Previews: PreviewProvider {
    static var previews: some View {
        DaySeven()
    }
}
