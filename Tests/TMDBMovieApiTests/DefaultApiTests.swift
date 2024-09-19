// This is free software: you can redistribute and/or modify it
// under the terms of the GNU General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
//
//  File.swift
//  
//
//  Created by Min Soe Zan on 10/9/24.
//

import Foundation

import XCTest

@testable import TMDBMovieApi

@available(macOS 13, *)
final class DefaultApiTests: XCTestCase {
    
    func testPopularMovies() async throws {
        let client = MockClient()
        let host = "https://api.themoviedb.org"
        let token = String.random
        
        let api = DefaultApi(host: host, token: token, httpClient: client)
        
        let movies = try await api.get(movieType: MovieType.popular, page: 1)
        
        XCTAssertNotNil(movies)
        
        XCTAssertEqual(client.request?.url?.absoluteString, host + "/3/movie/popular?page=1&language=en-US")
        XCTAssertEqual(client.request?.value(forHTTPHeaderField: "Authorization"), "Bearer \(token)")
        
        XCTAssertEqual(movies.results.first?.genreIDS.count, 3)
    }
    
    func testTopRatedMovies() async throws {
        let client = MockClient()
        let host = "https://api.themoviedb.org"
        let token = String.random
        
        let api = DefaultApi(host: host, token: token, httpClient: client)
        
        let movies = try await api.get(movieType: MovieType.top_rated, page: 1)
        
        XCTAssertNotNil(movies)
        
        XCTAssertEqual(client.request?.url?.absoluteString, host + "/3/movie/top_rated?page=1&language=en-US")
        XCTAssertEqual(client.request?.value(forHTTPHeaderField: "Authorization"), "Bearer \(token)")
    }
    
    func testGetMovies() async throws {
        let client = MockClient()
        let host = "https://api.themoviedb.org"
        let token = String.random
        
        let api = DefaultApi(host: host, token: token, httpClient: client)
        
        let movies = try await api.get(movieType: MovieType.top_rated, page: 3)
        
        XCTAssertNotNil(movies)
        
        XCTAssertEqual(client.request?.url?.absoluteString, host + "/3/movie/top_rated?page=3&language=en-US")
        XCTAssertEqual(client.request?.value(forHTTPHeaderField: "Authorization"), "Bearer \(token)")
    }
}

private class MockClient: HTTPClient {
    
    var request: URLRequest?
    
    func get(request: URLRequest) async throws -> Data {
        self.request = request
        
        guard let data = fakePopularMoviesResponse.data(using: String.Encoding.utf8) else {
            fatalError("unable to convert string to data")
        }
        return data
    }
}

extension String {
    
    static var random: Self {
        UUID().uuidString
    }
}
