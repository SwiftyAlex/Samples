//
//  DaySix.swift
//  12 Days
//
//  Created by Alex Logan on 30/12/2022.
//

import SwiftUI

struct DaySix: View {
    let startDate = Date()
    let happyNewYear = Date(timeIntervalSince1970: 1672531200) // <3

    @State var paused: Bool = false
    @State var number: Int = 9

    var body: some View {
        List {
            Section("Text") {
                // You can simply count down with a fancy text intialiser
                // This works in your widgets too!
                Text(timerInterval: Date()...happyNewYear, countsDown: true)
                // You can also show off the current date with a bunch of options!
                Text(happyNewYear.formatted(date: .abbreviated, time: .complete))
            }

            Section("TimelineView") {
                // If you're doing something else with the time, you can instead use a timeline view
                // This will update every single second without fail
                TimelineView(.animation(minimumInterval: 1, paused: paused)) { context in
                    HStack {
                        Text("Seconds until 2023")
                            .font(.subheadline)
                        Spacer()
                        let seconds = Int((happyNewYear.timeIntervalSince1970 - context.date.timeIntervalSince1970))
                        Text(seconds.formatted())
                            // Get a super smart animation when we animate
                            .contentTransition(.numericText(countsDown: true))
                            // Change font when we get to the final minute
                            .font((seconds <= 60 ? Font.subheadline : Font.title).weight(.semibold))
                            // Change color every even second
                            .foregroundColor(seconds % 2 == 0 ? .indigo : .primary)
                            .animation(.easeInOut, value: seconds)
                    }
                }
            }

            Button(action: {
                paused.toggle()
            }, label: {
                Text("Toggle Countdown")
                    .font(.subheadline.weight(.semibold))
            })
        }
    }
}

struct DaySix_Previews: PreviewProvider {
    static var previews: some View {
        DaySix()
    }
}
