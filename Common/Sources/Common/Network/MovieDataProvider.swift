//
//  MovieDataProvider.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

public protocol MovieDataProviderProtocol {
    func getMovies(from urlMovie: URLMoviesType) async -> [Movie]
}

public class MovieDataProvider: MovieDataProviderProtocol {
    let networkRequest: NetworkRequestUseCase

    public init(networkRequest: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkRequest = networkRequest
    }

    public func getMovies(from urlMovie: URLMoviesType) async -> [Movie] {
        guard let movieResponse: MovieResponseModel = await networkRequest.request(urlMovie: urlMovie) else {
            return []
        }

        let result = await setupDataOf(movieResponse: movieResponse, fromList: urlMovie).movies
        return result
    }

    private func setupDataOf(movieResponse: MovieResponseModel, fromList typeList: URLMoviesType) async -> MovieResponseModel {
        switch typeList {
        case .list(let movieListType):
            var result = movieResponse
            for index in 0..<result.movies.count {
                result.movies[index].movieType = movieListType
                result.movies[index].imageData = await networkRequest.request(
                    urlMovie: .image(
                        result.movies[index].posterPath
                    )
                )
            }
            return result

        default:
            return movieResponse
        }
    }
}
