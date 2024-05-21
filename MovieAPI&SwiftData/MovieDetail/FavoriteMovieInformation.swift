//
//  FavoriteMovieID.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData

@Model
class FavoriteMovieInformation: Hashable {
    @Attribute(.unique) let id: Int
    var movieType: MovieListType

    init(id: Int, movieType: MovieListType) {
        self.id = id
        self.movieType = movieType
    }
}
