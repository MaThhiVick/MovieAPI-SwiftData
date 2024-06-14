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
public class FavoriteMovieInformations: Hashable {
    @Attribute(.unique) public let id: Int
    var movieType: MovieListType
    public var title: String
    public var imageData: Data

    public init(id: Int, movieType: MovieListType, title: String, imageData: Data) {
        self.id = id
        self.movieType = movieType
        self.title = title
        self.imageData = imageData
    }
}
