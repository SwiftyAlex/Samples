//
//  async_swiftuiApp.swift
//  async-swiftui
//
//  Created by Alex Logan on 11/08/2021.
//

import SwiftUI

@main
struct async_swiftuiApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharactersAndEpisodesView(characterStore: CharacterStore(), episodeStore: EpisodeStore(), characters: [], episodes: [])
                    .environmentObject(AnalyticsManager())
            }
        }
    }
}
