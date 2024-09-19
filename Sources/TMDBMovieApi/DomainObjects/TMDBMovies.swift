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

public struct TMDBMovies: Decodable {
    public let page: Int
    public let results: [TMDBMovie]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct TMDBMovie: Decodable, Equatable, Hashable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIDS: [Genre]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath, releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public enum Genre: Int, Decodable {
    case action = 28
    case adventure = 12
    case animation = 16
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case family = 10751
    case fantasy = 14
    case history = 36
    case horror = 27
    case music = 10402
    case mystery = 9648
    case romance = 10749
    case science_fiction = 878
    case tv_movie = 10770
    case thriller = 53
    case war = 10752
    case western = 37
    
}


public extension Genre {
    
    var title: String {
        switch self {
        case .action:
            "Action"
        case .adventure:
            "Adventure"
        case .animation:
            "Animation"
        case .comedy:
            "Comedy"
        case .crime:
            "Crime"
        case .documentary:
            "Documentary"
        case .drama:
            "Drama"
        case .family:
            "Family"
        case .fantasy:
            "Fantasy"
        case .history:
            "Histroy"
        case .horror:
            "Horror"
        case .music:
            "Music"
        case .mystery:
            "Mystery"
        case .romance:
            "Romance"
        case .science_fiction:
            "Science Fiction"
        case .tv_movie:
            "TV Movie"
        case .thriller:
            "Thriller"
        case .war:
            "War"
        case .western:
            "Western"
        }
    }

}
