//
//  BrewerDetailView.swift
//  Brew Book
//
//  Created by Alex Logan on 06/06/2023.
//

import SwiftUI

/// NOTE: Live update only works due to the trick with deletion shown below.
struct BrewerDetailView: View {
    @Environment(\.modelContext) var context
    @State var showAddBrew: Bool = false

    let brewer: Brewer

    var body: some View {
        List {
            ForEach(brewer.brews ?? [], id: \.self) { brew in
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

            if (brewer.brews ?? []).isEmpty {
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
        withAnimation {
            context.delete(brew)
            // We have to explicitly remove from the array, or the view won't update.
            brewer.brews?.removeAll(where: { innerBrew in
                innerBrew == brew
            })
        }
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
                Text(brew.brewType.rawValue)
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
