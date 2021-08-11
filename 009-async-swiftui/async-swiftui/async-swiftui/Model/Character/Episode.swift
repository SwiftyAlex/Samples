//
//  Episode.swift
//  Episode
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

struct Episode: Codable, Hashable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
    
    #if DEBUG
    static let testEpisode = Episode(id: 0, name: "Episode 1", airDate: "", episode: "1", characters: [""], url: "", created: "")
    #endif
}
