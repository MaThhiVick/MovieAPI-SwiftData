//
//  MovieDetailModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

public struct MovieDetailModel: Decodable {
    public let id: Int
    public let adult: Bool
    public let backdropPath: String
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int
    public let genres: [Genre]
    public let homepage: String
    public let imdbId: String?
    public let originalLanguage: String
    public let originalTitle: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: String
    public let revenue: Int
    public let runtime: Int
    public let spokenLanguages: [SpokenLanguage]
    public let status: String
    public let tagline: String
    public let title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
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

public struct BelongsToCollection: Codable {
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

public struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?

    private enum CodingKeys: String, CodingKey {
        case id, logoPath = "logo_path", name, originCountry = "origin_country"
    }
}

public struct ProductionCountry: Codable {
    let iso31661: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1", name
    }
}

public struct SpokenLanguage: Codable {
    let englishName: String?
    let iso6391: String?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name", iso6391 = "iso_639_1", name
    }
}
