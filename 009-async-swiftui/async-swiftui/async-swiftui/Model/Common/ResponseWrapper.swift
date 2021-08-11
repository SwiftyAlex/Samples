//
//  ResponseWrapper.swift
//  async-swiftui
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

struct ResponseWrapper<Content: Codable>: Codable {
    let info: ResponseInfo
    let results: [Content]
}

struct ResponseInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}
