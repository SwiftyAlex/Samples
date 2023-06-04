//
//  ContentView.swift
//  12 Days
//
//  Created by Alex Logan on 26/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State var dayTenText: String = ""

    var body: some View {
        DayTwelve()
    }

    var firstSet: some View {
        Group {
            NavigationLink(destination: DayOne(), label: {
                Text("Scroll if needed")
            })
            NavigationLink(destination: DayTwo(), label: {
                Text("Wrapping Geometry Reader")
            })
            NavigationLink(destination: DayThree(), label: {
                Text("Debugging")
            })
            NavigationLink(destination: DayFour(), label: {
                Text("Reserving Space")
            })
            NavigationLink(destination: DayFive(), label: {
                Text("Color Schemes")
            })
            NavigationLink(destination: DaySix(), label: {
                Text("Time")
            })
            NavigationLink(destination: DaySeven(), label: {
                Text("Clean Lists")
            })
            NavigationLink(destination: DayEight(), label: {
                Text("Nice buttons")
            })
            NavigationLink(destination: DayNine(), label: {
                Text("Location Button")
            })
            NavigationLink(destination: DayTen(text: $dayTenText), label: {
                Text("Previews")
            })
        }
    }

    var secondSet: some View {
        Group {
            NavigationLink(destination: DayEleven(), label: {
                Text("Environment")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
