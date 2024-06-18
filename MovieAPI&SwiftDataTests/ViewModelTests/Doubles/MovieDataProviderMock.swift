//
//  MovieDataProviderMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Common
@testable import MovieAPI_SwiftData

class MovieDataProviderMock: MovieDataProviderProtocol {
    func getMovies(from urlMovie: URLMoviesType) async -> [Movie] {
        return MovieResponseModelMock.getMovieResponse()
    }
}
