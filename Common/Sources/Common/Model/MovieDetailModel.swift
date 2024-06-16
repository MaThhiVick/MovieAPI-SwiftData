//
//  MovieDetailModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//
// change name and this public, typealias ?
public struct MovieDetailModel: Decodable {
    public let id: Int
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    public let genres: [Genre]
    public let homepage: String
    let imdbId: String?
    let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    public let releaseDate: String
    let revenue: Int
    public let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    public let voteAverage: Double
    let voteCount: Int
}

extension MovieDetailModel {
    private enum CodingKeys: String, CodingKey {
        case adult, backdropPath = "backdrop_path", belongsToCollection = "belongs_to_collection",
             budget, genres, homepage, id, imdbId = "imdb_id", originalLanguage = "original_language",
             originalTitle = "original_title", overview, popularity, posterPath = "poster_path",
             productionCompanies = "production_companies", productionCountries = "production_countries",
             releaseDate = "release_date", revenue, runtime, spokenLanguages = "spoken_languages",
             status, tagline, title, video, voteAverage = "vote_average", voteCount = "vote_count"
    }
}

struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, posterPath = "poster_path", backdropPath = "backdrop_path"
    }
}

public struct Genre: Codable {
    let id: Int?
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    private enum CodingKeys: String, CodingKey {
        case id, logoPath = "logo_path", name, originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso31661: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1", name
    }
}

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso6391: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name", iso6391 = "iso_639_1", name
    }
}
