//
//  CharacterStore.swift
//  async-swiftui
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

class CharacterStore: ObservableObject {
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchCharacters() async throws -> [Character] {
        let urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/api/character")!)
        let (data, _) = try await urlSession.data(for: urlRequest, delegate: nil)
        let decodedData = try jsonDecoder.decode(ResponseWrapper<Character>.self, from: data)
        return decodedData.results
    }
    
}
