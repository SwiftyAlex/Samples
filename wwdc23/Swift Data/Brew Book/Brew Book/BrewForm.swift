//
//  BrewForm.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import SwiftUI
import SwiftData

struct BrewForm: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State var brewer: Brewer
    @State var brewType: BrewType = .espresso
    @State var rating: Int = 5
    @State var brewDate: Date = Date()

    var body: some View {
        Form {
            Picker(
                selection: $brewType,
                content: {
                    ForEach(BrewType.allCases, id: \.self) { brewType in
                        Text(brewType.rawValue)
                    }
                }, label: {
                    Text("Brew Type")
                }
            )

            Stepper(value: $rating, label: {
                Text("Rating: \(rating.formatted())")
            })

            DatePicker("Brew Date", selection: $brewDate)
                .pickerStyle(.inline)

            Button(action: {
                self.save()
                self.dismiss()
            }, label: {
                Text("Save")
            })
        }
    }

    func save() {
        let brew = Brew(
            type: brewType,
            rating: rating,
            brewDate: brewDate
        )

        // Setting the inverse of the relationship does not live update as you'd expect
        // brew.brewer = brewer
        // context.insert(brew)

        // Setting this way, does, so we'll do that for now.
        brewer.brews.append(brew)
        do {
            // Try to save
            try context.save()
        } catch {
            // We couldn't save :(
            // Failures include issues such as an invalid unique constraint
            print(error.localizedDescription)
        }
    }
}

#Preview {
    BrewForm(brewer: .init(name: "Preview Brewer"))
}
