//
//  MovieListModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

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

struct Dates: Codable {
    let maximum: String
    let minimum: String
}
