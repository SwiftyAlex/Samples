import Foundation

// Constants
public struct Constants {
    // API
    public static let charactersUrl = URL(string: "https://rickandmortyapi.com/api/character")!
    public static let rickImageUrl = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    // Fake Url
    public static let notRealUrl = URL(string: "https://thisisnotarealurl.com")!

}

// Models
public struct ResponseWrapper<Content: Codable>: Codable {
    public let info: ResponseInfo
    public let results: [Content]
}

public struct ResponseInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

public struct Character: Codable {
    public let id: Int
    public let name: String
}

public struct ImageResponse: Decodable {
    let location: URL
}

// Mock Service
public class AuthenticationService {
    public init() { }
    
    public func getToken() async -> String {
        return "token"
    }
}

// Network Errors
public enum NetworkError: Error {
    case badRequest, badResponse, unauthenticated, serverError
    case generic(code: Int)
    
    public init(from httpStatusCode: Int) {
        switch httpStatusCode {
        case 401, 403:
            self = .unauthenticated
        case 500:
            self = .serverError
        default:
            self = .generic(code: httpStatusCode)
        }
    }
}


class ClosureAuthenticationService {
    func getToken(closure: @escaping (Result<String, Error>) -> ()) {
        closure(.success("token"))
    }
}

// Really bad example of closure networking
public class ClosureNetwork {
    private let authenticationService = ClosureAuthenticationService()
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    private let urlSession = URLSession.shared
    
    public init() { }
    
    public func requestData<D: Decodable>(_ responseType: D.Type, from url: URL, resultClosure: @escaping (Result<D, Error>) -> ()) {
        // Grab a token & setup our request
        authenticationService.getToken { tokenResult in
            switch tokenResult {
                case .success(let token):
                    var request = URLRequest(url: url)
                    request.addValue(token, forHTTPHeaderField: "authentication")
                    // Make the request and validate the response
                    let dataTask = self.urlSession.dataTask(with: request) { data, response, error in
                        if let urlResponse = response as? HTTPURLResponse, !(200..<300 ~= urlResponse.statusCode) {
                            resultClosure(.failure(NetworkError(from: urlResponse.statusCode)))
                            return
                        }
                        guard let data = data else {
                            resultClosure(.failure(NetworkError.badResponse))
                            return
                        }
                        // Return the JSON if we can decode it properly
                        do {
                            let json = try self.jsonDecoder.decode(responseType, from: data)
                            resultClosure(.success(json))
                        } catch (let jsonError) {
                            resultClosure(.failure(jsonError))
                        }
                    }
                    dataTask.resume()
                case .failure(let err):
                    resultClosure(.failure(err))
            }
        }
    }
}
