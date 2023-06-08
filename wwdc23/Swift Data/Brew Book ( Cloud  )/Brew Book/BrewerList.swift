//
//  BrewerList.swift
//  Brew Book
//
//  Created by Alex Logan on 05/06/2023.
//

import SwiftUI
import SwiftData
import CoreData

struct BrewerList: View {
    @Environment(\.modelContext) var context
    @State var showAddBrewer: Bool = false

    @Query(sort: \.name, order: .forward)
    var brewers: [Brewer]

    var body: some View {
        List {
            ForEach(brewers, id: \.self) { brewer in
                BrewerView(brewer: brewer)
                    .swipeActions(content: {
                        Button(action: {
                            self.delete(brewer: brewer)
                        }, label: {
                            Label("Delete", systemImage: "xmark.bin.fill")
                        })
                        .tint(Color.red)
                    })
            }

            if brewers.isEmpty {
                Text("Add your first brewer by tapping plus.")
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
                    showAddBrewer = true
                }, label: {
                    Label("Add", systemImage: "plus.circle.fill")
                })
            })
        })
        .sheet(isPresented: $showAddBrewer, content: {
            NavigationStack {
                BrewerForm()
            }
        })
        .onReceive(NotificationCenter.default.publisher(
            for: NSPersistentCloudKitContainer.eventChangedNotification
        )) { notification in
            guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
                return
            }
            if event.endDate != nil && event.type == .import {
                Task { @MainActor in
                    let brewersFetchDescriptor = FetchDescriptor<Brewer>(
                        predicate: nil,
                        sortBy: [.init(\.name)]
                    )
                    _ = try? context.fetch(brewersFetchDescriptor)
                }
            }
        }
        .navigationTitle("Brewers")
    }

    func delete(brewer: Brewer) {
        context.delete(brewer)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

private struct BrewerView: View {
    var brewer: Brewer

    var body: some View {
        NavigationLink(value: brewer) {
            HStack {
                Text(brewer.name)
                    .font(.body.weight(.medium))
                Spacer()
            }
        }
    }
}

#Preview {
    BrewerList()
}
