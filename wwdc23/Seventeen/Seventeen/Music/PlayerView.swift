//
//  PlayerView.swift
//  Seventeen
//
//  Created by Alex Logan on 08/06/2023.
//

import SwiftUI

struct PlayerView: View {
    private let player: Player = .shared

    var body: some View {
        List {
            Button(action: {
                player.play()
            }, label: {
                Text("Play")
            })
        }
    }
}

#Preview {
    PlayerView()
}
