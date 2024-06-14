//
//  FavoriteMovieID.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import NetworkService
import SwiftUI

@Model
class FavoriteMovieInformations: Hashable {
    @Attribute(.unique) let id: Int
    var movieType: MovieListType
    var title: String
    var imageData: Data

    init(id: Int, movieType: MovieListType, title: String, imageData: Data) {
        self.id = id
        self.movieType = movieType
        self.title = title
        self.imageData = imageData
    }
}
