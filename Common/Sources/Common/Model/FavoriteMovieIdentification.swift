//
//  FavoriteMovieID.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import Foundation

@available(macOS 14, *)
@Model
public class FavoriteMovieIdentification: Hashable {
    @Attribute(.unique) public let id: Int
    var movieType: MovieListType

    public init(id: Int, movieType: MovieListType) {
        self.id = id
        self.movieType = movieType
    }
}
