//
//  RunTrackerView.swift
//  Run Tracker
//
//  Created by Alex Logan on 07/06/2023.
//

import SwiftUI

struct RunTrackerView: View {
    @Environment(\.dismiss) var dismiss

    let runStore: RunStore

    var body: some View {
        VStack(alignment: .leading) {
            Text("Track Run")
                .font(.title.weight(.bold))
                .fontDesign(.rounded)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(CommonRun.allCases, id: \.self) { run in
                        Button(action: {
                            Task {
                               await runStore.track(kilomereDistance: run.rawValue)
                               dismiss()
                            }
                        }, label: {
                            Text(run.title)
                                .font(.headline.bold())
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    Color.mint.gradient,
                                    in: RoundedRectangle(cornerRadius: 12)
                                )
                        })
                        .buttonStyle(BasicSquishyButtonStyle())
                    }
                }
            }
            .contentMargins(.horizontal, 20, for: .scrollContent)
        }
        .presentationDetents(
            [.fraction(0.2)]
        )
    }
}

struct BasicSquishyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)
    }
}


#Preview {
    List {

    }
    .sheet(isPresented: .constant(true), content: {
        RunTrackerView(runStore: .init())
    })
}
