import UIKit
import PlaygroundSupport
import Foundation

// One
// A basic request that will get data from the given URL
let url = Constants.charactersUrl
async {
    let (data, response) = try await URLSession.shared.data(from: url)
    print(data)
    print(response)
}

// Two
let urlRequest = URLRequest(url: url)
async {
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    print(data)
    print(response)
}

// Three
class Network {
    private let authenticationService = AuthenticationService()
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    private let urlSession = URLSession.shared
    
    func requestData<D: Decodable>(_ responseType: D.Type, from url: URL) async throws -> D {
        // Grab a token & setup our request
        let token = await authenticationService.getToken()
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "authentication")
        // Make the request and validate the response
        let (data, response) = try await urlSession.data(for: request)
        if let urlResponse = response as? HTTPURLResponse, !(200..<300 ~= urlResponse.statusCode) {
            throw NetworkError(from: urlResponse.statusCode)
        }
        // Return the JSON if we can decode it properly
        return try jsonDecoder.decode(responseType, from: data)
    }
    
    func postData<E: Encodable, D: Decodable>(_ responseType: D.Type, data: E, to url: URL) async throws -> D {
        // Grab a token & setup our request
        let token = await authenticationService.getToken()
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "authentication")
        request.httpMethod = "POST"
        // Encode the data
        request.httpBody = try jsonEncoder.encode(data)
        // Make the request and validate the response
        let (data, response) = try await urlSession.data(for: request)
        if let urlResponse = response as? HTTPURLResponse, !(200..<300 ~= urlResponse.statusCode) {
            throw NetworkError(from: urlResponse.statusCode)
        }
        // Return the JSON if we can decode it properly
        return try jsonDecoder.decode(responseType, from: data)
    }
}

// Four
let network = Network()
async {
    do {
        let characterResponse = try await network.requestData(ResponseWrapper<Character>.self, from: Constants.charactersUrl)
        // Do something with our characters
        for character in characterResponse.results {
            print(character.name)
        }
    } catch (let error) {
        print(error)
    }
}

// Five - Uploading

// I unfortunatley don't have a real endpoint for this - so it'll always fail - but that helps us test error handling!
extension Network {
    func uploadData<R: Decodable>(data: Data, to url: URL, responseType: R.Type) async throws -> R {
        // Grab a token & setup our request
        let token = await authenticationService.getToken()
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "authentication")
        request.httpMethod = "POST"
        let (responseData, response) = try await self.urlSession.upload(for: request, from: data)
        if let urlResponse = response as? HTTPURLResponse, !(200..<300 ~= urlResponse.statusCode) {
            throw NetworkError(from: urlResponse.statusCode)
        }
        // Return the JSON if we can decode it properly
        return try jsonDecoder.decode(responseType, from: responseData)
    }
}

async {
    do {
        let image = UIImage(named: "Evermore")
        let imageResponse = try await network.uploadData(data: image!.jpegData(compressionQuality: 0.1)!, to: Constants.notRealUrl, responseType: ImageResponse.self)
        print(imageResponse)
    } catch (let error) {
        print(error)
    }
}

// Six - Downloading
extension Network {
    func downloadData(from url: URL) async throws -> URL {
        // Grab a token & setup our request
        let token = await authenticationService.getToken()
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "authentication")
        request.httpMethod = "GET"
        let (url, response) = try await self.urlSession.download(for: request)
        if let urlResponse = response as? HTTPURLResponse, !(200..<300 ~= urlResponse.statusCode) {
            throw NetworkError(from: urlResponse.statusCode)
        }
        // Return the URL for this download
        return url
    }
}

async {
    do {
        let rickImageDownloadUrl = try await network.downloadData(from: Constants.rickImageUrl)
        print(rickImageDownloadUrl)
    } catch (let error) {
        print(error)
    }
}


// Playground Management
PlaygroundPage.current.needsIndefiniteExecution = true
