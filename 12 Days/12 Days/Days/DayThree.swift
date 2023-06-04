//
//  DayThree.swift
//  12 Days
//
//  Created by Alex Logan on 28/12/2022.
//

import SwiftUI

struct DayThree: View {
    @State var count = 0

    var body: some View {
        let _ = Self._printChanges()
        List {
            Text("Button tapped \(count.formatted()) times!")

            Button(action: {
                count = count + 1
            }, label: {
                Text("Increment")
            })
        }
    }
}

struct DayThree_Previews: PreviewProvider {
    static var previews: some View {
        DayThree()
    }
}
