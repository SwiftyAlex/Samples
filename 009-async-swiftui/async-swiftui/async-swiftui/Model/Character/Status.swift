//
//  Status.swift
//  async-swiftui
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

enum Status: String, Codable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
