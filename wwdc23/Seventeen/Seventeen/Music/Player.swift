//
//  Player.swift
//  Seventeen
//
//  Created by Alex Logan on 08/06/2023.
//

import Foundation
import AVKit

class Player {
    static let shared: Player = .init()

    private var player: AVAudioPlayer?

    func play() {
        guard let songUrl = Bundle.main.url(forResource: "song", withExtension: "mp3") else { return }
        guard let player = try? AVAudioPlayer(contentsOf: songUrl) else { return }
        self.player = player
        _ = player.prepareToPlay()
        player.play()
    }

    func resume() {
        self.player?.play()
    }

    func pause() {
        self.player?.stop()
    }
}
