//
//  BrewerDetailView.swift
//  Brew Book
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

/// NOTE: Live update is currently not working, so after adding a brew you'll need to go back out of this view and come back in.
/// This should be fixed in a future beta, but for now, after deleting a brew, or adding a new one, you'll need to peek and pop this view.
struct BrewerDetailView: View {
    @Environment(\.modelContext) var context
    @State var showAddBrew: Bool = false

    let brewer: Brewer

    var body: some View {
        List {
            ForEach(brewer.brews, id: \.self) { brew in
                BrewView(brew: brew)
                    .swipeActions(content: {
                        Button(action: {
                            self.delete(brew: brew)
                        }, label: {
                            Label("Delete", systemImage: "xmark.bin.fill")
                        })
                        .tint(Color.red)
                    })
            }

            if brewer.brews.isEmpty {
                Text("Add your first brew by tapping plus.")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity, alignment: .center)

            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    showAddBrew = true
                }, label: {
                    Label("Add", systemImage: "plus.circle.fill")
                })
            })
        })
        .sheet(isPresented: $showAddBrew, content: {
            NavigationStack {
                BrewForm(brewer: brewer)
            }
        })
        .navigationTitle(brewer.name)
    }

    func delete(brew: Brew) {
        context.delete(brew)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

private struct BrewView: View {
    var brew: Brew

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(brew.type.rawValue)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Text(brew.rating.formatted())
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(brew.brewDate.formatted())
                .font(.body.weight(.medium))
                .foregroundStyle(.primary)
        }
        .font(.body.weight(.medium))
    }
}

#Preview {
    BrewerDetailView(brewer: .init(name: "<3"))
}
