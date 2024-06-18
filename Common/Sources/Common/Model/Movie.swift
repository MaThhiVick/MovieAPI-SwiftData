//
//  File.swift
//  
//
//  Created by Matheus Vicente on 18/06/24.
//

import Foundation

public struct Movie: Codable, Hashable {
    public let adult: Bool
    public let backdropPath: String
    public let genreIDs: [Int]
    public let id: Int
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String
    public let releaseDate: String
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public var imageData: Data?
    public var isFavorite: Bool?
    public var movieType: MovieListType?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case imageData
    }
}
