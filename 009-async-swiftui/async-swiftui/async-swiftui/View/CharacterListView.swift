//
//  CharacterListView.swift
//  CharacterListView
//
//  Created by Alex Logan on 11/08/2021.
//

import SwiftUI

struct CharacterListView: View {
    @State var characters: [Character] = []
    
    var body: some View {
        LazyVStack {
            ForEach(characters, id: \.self) { character in
                CharacterView(character: character)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .foregroundColor(Color(uiColor: .systemBackground))
                    )
            }
        }
    }
}

#if DEBUG
struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(characters: [.rick])
            .environmentObject(AnalyticsManager())
    }
}
#endif
