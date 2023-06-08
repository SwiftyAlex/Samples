//
//  PlayerIntent.swift
//  Seventeen
//
//  Created by Alex Logan on 08/06/2023.
//

import Foundation
import AppIntents

enum PlayerAction: Int, AppEnum {
    typealias RawValue = Int

    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(stringLiteral: "Player Action")

    static var caseDisplayRepresentations: [PlayerAction : DisplayRepresentation] = [
        .pause: .init(stringLiteral: "Pause"),
        .play: .init(stringLiteral: "Play"),
        .resume: .init(stringLiteral: "Resume"),
    ]

    case play, pause, resume
}

struct PlayerIntent: LiveActivityIntent {
    static var title: LocalizedStringResource = "Player Intent"

    @Parameter(title: "Player Action")
    var action: PlayerAction

    init() { self.action = .play }
    init(action: PlayerAction = .play) { self.action = action }

    func perform() async throws -> some IntentResult {
        switch action {
        case .play:
            Player.shared.play()
        case .pause:
            Player.shared.pause()
        case .resume:
            Player.shared.resume()
        }
        return .result(value: true)
    }
}
