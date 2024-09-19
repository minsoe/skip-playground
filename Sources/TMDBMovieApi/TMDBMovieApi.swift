// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import Foundation
import OSLog

public protocol TMDBMovieApi {
    
    func get(movieType: MovieType, page: Int) async throws -> TMDBMovies
}

public enum TMDBMovieApiFactory {
    public static func make(token: String) -> TMDBMovieApi {
        DefaultApi(token: token, httpClient: URLSessionClient())
    }
}

public protocol HTTPClient {
    
    func get(request: URLRequest) async throws -> Data
}

private struct URLSessionClient: HTTPClient {
    
    private let session: URLSession = URLSession.shared
    
    func get(request: URLRequest) async throws -> Data {
        try await session.data(for: request).0
    }
}

struct DefaultApi: TMDBMovieApi {
    
    enum Error: Swift.Error {
        case invalidUrl
    }
    
    let token: String
    let httpClient: HTTPClient
    
    func get(movieType: MovieType, page: Int = 1) async throws -> TMDBMovies {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieType)")
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "language", value: "en-US"),
        ]
        
        guard let url = components?.url else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let rawData = try await httpClient.get(request: request)
        return try JSONDecoder().decode(TMDBMovies.self, from: rawData)
    }
}

public enum MovieType: String {
    case popular
    case top_rated
}
