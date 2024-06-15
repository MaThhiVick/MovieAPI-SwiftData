//
//  MovieListModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

// MARK: - Dates
struct Dates: Codable {
    let maximum: String
    let minimum: String
}

// MARK: - MovieResponse
struct MovieResponseModel: Codable {
    let dates: Dates?
    let page: Int
    var movies: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
public struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIDs: [Int]
    public let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    public let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
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

extension Movie {
    static public func create(id: Int, title: String, overview: String) -> Movie {
        return Movie(adult: false,
                     backdropPath: "",
                     genreIDs: [],
                     id: id,
                     originalLanguage: "",
                     originalTitle: "",
                     overview: overview,
                     popularity: 0.0,
                     posterPath: "",
                     releaseDate: "",
                     title: title,
                     video: false,
                     voteAverage: 0.0,
                     voteCount: 0,
                     imageData: nil,
                     isFavorite: nil,
                     movieType: nil)
    }
}
