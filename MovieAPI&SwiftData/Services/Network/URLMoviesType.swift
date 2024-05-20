//
//  URLMoviesType.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

enum URLMoviesType {
    case detail(Int)
    case image(String)
    case list(MovieListPath)

    var stringName: String {
        switch self {
        case .detail:
            "movieDetail"
        case .image:
            "movieImage"
        default:
            "movieList"
        }
    }
}

enum MovieListPath: String, CaseIterable {
    case topRated = "top_rated"
    case popular
}
