//
//  EpisodeStore.swift
//  EpisodeStore
//
//  Created by Alex Logan on 11/08/2021.
//

import Foundation

class EpisodeStore: ObservableObject {
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchEpisodes() async throws -> [Episode] {
        let urlRequest = URLRequest(url: URL(string: "https://rickandmortyapi.com/api/episode")!)
        let (data, _) = try await urlSession.data(for: urlRequest, delegate: nil)
        let decodedData = try jsonDecoder.decode(ResponseWrapper<Episode>.self, from: data)
        return decodedData.results
    }
    
}
