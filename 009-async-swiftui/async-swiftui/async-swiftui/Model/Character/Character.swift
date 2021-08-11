//
//  Character.swift
//  async-swiftui
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

struct Character: Hashable, Codable, Equatable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    #if DEBUG
    static let rick = Character(id: 0, name: "Rick", status: .alive, species: .human, type: "Main Guy", gender: .male, origin: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), location: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
    #endif
}
