//
//  MovieDataProviderMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

@testable import MovieAPI_SwiftData

class MovieDataProviderMock: MovieDataProviderProtocol {
    func getMovies(from urlMovie: MovieAPI_SwiftData.URLMoviesType) async -> [MovieAPI_SwiftData.Movie] {
        return MovieResponseModel.getMovieResponse().movies
    }
}
