//
//  CharactersAndEpisodesView.swift
//  CharactersAndEpisodesView
//
//  Created by Alex Logan on 11/08/2021.
//

import SwiftUI

enum CharactersAndEpisodesViewState {
    case loading, error, showCharacters, showEpisodes
}
enum CharactersAndEpisodesViewOption: Int {
    case characters, episodes
}

struct CharactersAndEpisodesView: View {
    @StateObject var characterStore: CharacterStore
    @StateObject var episodeStore: EpisodeStore
    
    @State var viewState: CharactersAndEpisodesViewState = .loading
    @State var characters: [Character]
    @State var episodes: [Episode]
    @State var selection: CharactersAndEpisodesViewOption = .characters
        
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Would you like to see characters or episodes?")) {
                Text("Characters").tag(CharactersAndEpisodesViewOption.characters)
                Text("Episodes").tag(CharactersAndEpisodesViewOption.episodes)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            ScrollView {
                LazyVStack {
                    contentBody
                        .padding()
                }
            }
        }
        .task(id: selection, {
            await loadContent()
        })
        .navigationTitle("Rick & Morty")
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    func loadContent() async {
        do {
            self.viewState = .loading
            switch selection {
            case .characters:
                self.characters = try await characterStore.fetchCharacters()
                guard !Task.isCancelled else { return }
                self.viewState = .showCharacters
            case .episodes:
                self.episodes = try await episodeStore.fetchEpisodes()
                guard !Task.isCancelled else { return }
                self.viewState = .showEpisodes
            }
        } catch {
            self.viewState = .error
        }
    }

    // MARK: - Child Views
    @ViewBuilder
    var contentBody: some View {
        switch viewState {
        case .loading:
            loadingView
        case .error:
            errorView
        case .showCharacters:
            CharacterListView(characters: characters)
        case .showEpisodes:
            EpisodeListView(episodes: episodes)
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        Spacer()
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        Spacer()
    }
    
    @ViewBuilder
    var errorView: some View {
        Spacer()
        VStack(alignment: .center, spacing: 12) {
            Text("It looks like something has gone wrong, try a different option to reload.")
        }
        .padding()
        Spacer()
    }

}

#if DEBUG
struct CharactersAndEpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersAndEpisodesView(characterStore: CharacterStore(), episodeStore: EpisodeStore(), characters: [], episodes: [])
            .environmentObject(AnalyticsManager())
    }
}
#endif
