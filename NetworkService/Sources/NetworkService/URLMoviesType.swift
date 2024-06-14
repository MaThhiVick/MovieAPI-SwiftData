//
//  URLMoviesType.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

public enum URLMoviesType {
    case detail(Int)
    case image(String)
    case list(MovieListType)

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

public enum MovieListType: String, CaseIterable, Codable {
    case topRated = "top_rated"
    case popular
}
