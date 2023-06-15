//
//  WeekSummaryView.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import SwiftUI
import SwiftData

struct WeekSummaryView: View {
    let runStore: RunStore

    static var startOfLastWeek: Double {
        Date().addingTimeInterval(-604800).timeIntervalSince1970
    }

    // This query, no matter what the date, if you use `Date` will always return nothing.
    // I've tried a bunch of approaches and can't get it to co-operate, so for now, it just shows all runs.
    // Other simple predicates do work, so this is just strange
    // NOTE: This is confirmed as a bug with Date in predicates, so I've swapped it out to doubles
    @Query(
        filter: #Predicate {
            $0.date > startOfLastWeek
        },
        sort: \.date,
        animation: .bouncy
    )
    var runs: [Run]

    @State var showSheet: Bool = false

    var body: some View {
        List {
            header
                .fontDesign(.rounded)
                .navigationTitle(Text("This Week"))
                .padding(60)

            runList
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.headline.weight(.bold))
                        .fontDesign(.rounded)
                })
            })
        }
        .sheet(isPresented: $showSheet, content: {
            RunTrackerView(runStore: runStore)
        })
    }

    var header: some View {
        HStack(alignment: .center) {
            Text(runs.reduce(0, { $0 + $1.kilometers }).formatted(.number))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.mint.gradient)

            Text("km")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color.mint.gradient)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    var runList: some View {
        Section("Your runs") {
            ForEach(runs, id: \.id) { run in
                HStack {
                    Text(run.actualDate.formatted())
                    Spacer()
                    Text(run.kilometers.formatted())
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WeekSummaryView(runStore: .init())
    }
}
