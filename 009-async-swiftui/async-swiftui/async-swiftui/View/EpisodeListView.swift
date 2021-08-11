//
//  EpisodeListView.swift
//  EpisodeListView
//
//  Created by Alex Logan on 11/08/2021.
//

import SwiftUI

struct EpisodeListView: View {
    @State var episodes: [Episode] = []
    
    var body: some View {
        LazyVStack {
            ForEach(episodes, id: \.self) { episode in
                EpisodeView(episode: episode)
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
struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView(episodes: [.testEpisode])
    }
}
#endif
