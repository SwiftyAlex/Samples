//
//  BrewerForm.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import SwiftUI
import SwiftData

struct BrewerForm: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State var brewerName: String = ""

    var body: some View {
        Form {
            TextField("Brewer Name", text: $brewerName)

            Button(action: {
                self.save()
                self.dismiss()
            }, label: {
                Text("Save")
            })
        }
        .navigationTitle("Your Brewer")
    }

    func save() {
        let brewer = Brewer(name: brewerName)
        context.insert(brewer)
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
    BrewerForm()
}
