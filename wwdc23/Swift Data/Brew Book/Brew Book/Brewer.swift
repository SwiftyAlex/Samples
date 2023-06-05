//
//  Brewer.swift
//  Brew Book
//
//  Created by Alex Logan on 06/06/2023.
//

import Foundation
import SwiftData

@Model final class Brewer {
    var name: String

    @Relationship(.cascade, inverse: \Brew.brewer)
    var brews: [Brew] = []

    init(name: String) {
        self.name = name
    }
}
