//
//  MovieDataProvider.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

protocol MovieDataProviderProtocol {
    func getMovies(from urlMovie: URLMoviesType) async -> [Movie]
}

class MovieDataProvider: MovieDataProviderProtocol {
    let networkRequest: NetworkRequestUseCase

    init(networkRequest: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkRequest = networkRequest
    }

    func getMovies(from urlMovie: URLMoviesType) async -> [Movie] {
        guard let movieResponse: MovieResponseModel = await networkRequest.request(urlMovie: urlMovie) else {
            return []
        }

        let result = await insertImageData(movieResponse: movieResponse).movies
        return result
    }

    private func insertImageData(movieResponse: MovieResponseModel) async -> MovieResponseModel {
        var result = movieResponse
        for movie in 0..<result.movies.count {
            result.movies[movie].imageData = await networkRequest.request(
                urlMovie: .image(
                    result.movies[movie].posterPath
                )
            )
        }
        return result
    }
}
