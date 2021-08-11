//
//  BasicCharacterListView.swift
//  BasicCharacterListView
//
//  Created by Alex Logan on 11/08/2021.
//

import SwiftUI

struct BasicCharacterListView: View {
    @StateObject var characterStore = CharacterStore()
    @State var characters: [Character] = []
    @State var showFailure: Bool = false

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(characters, id: \.self) { character in
                    CharacterView(character: character)
                }
            }
        }
        .alert("Something went wrong.", isPresented: $showFailure) {
            Button("OK", role: .cancel) { }
        }
        .task {
            do {
                self.characters = try await characterStore.fetchCharacters()
            } catch {
                self.showFailure = true
            }
        }
    }
}

#if DEBUG
struct BasicCharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        BasicCharacterListView()
    }
}
#endif
