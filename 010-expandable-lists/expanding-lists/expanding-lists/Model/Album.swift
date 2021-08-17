//
//  Album.swift
//  expanding-lists
//
//  Created by Alex Logan on 16/08/2021.
//

import Foundation

struct Album: Hashable {
    let image: String
    let name: String
    
    static let all: [Album] = [
        Album(image: "1989", name: "1989"),
        Album(image: "reputation", name: "Reputation"),
        Album(image: "lover", name: "Lover"),
        Album(image: "folklore", name: "Folklore"),
        Album(image: "evermore", name: "Evermore"),
        Album(image: "fearless (taylors version)", name: "Fearless ( Taylor's Version )"),
    ]
}
