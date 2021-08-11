//
//  EpisodeView.swift
//  EpisodeView
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation
import SwiftUI

struct EpisodeView: View {
    let episode: Episode
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            informationView
            Spacer()
        }
    }
    
    var informationView: some View {
        VStack(alignment: .leading) {
            Text(episode.name)
                .font(.headline)
            Text(episode.episode)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#if DEBUG
struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: .testEpisode)
    }
}
#endif
