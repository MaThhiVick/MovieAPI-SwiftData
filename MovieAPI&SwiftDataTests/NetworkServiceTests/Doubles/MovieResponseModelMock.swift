//
//  MovieResponseModelMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Foundation
@testable import MovieAPI_SwiftData

extension MovieResponseModel: Equatable {
    public static func == (
        lhs: MovieAPI_SwiftData.MovieResponseModel,
        rhs: MovieAPI_SwiftData.MovieResponseModel
    ) -> Bool {
        return lhs.movies == rhs.movies
    }

    static func getMovieResponse() -> MovieResponseModel {
        return MovieResponseModel(
            dates: Dates(maximum: "2023-12-31", minimum: "2023-01-01"),
            page: 1,
            movies: [
                Movie(
                    adult: false,
                    backdropPath: "/example_backdrop_path.jpg",
                    genreIDs: [12, 34, 56],
                    id: 123,
                    originalLanguage: "en",
                    originalTitle: "Example Movie",
                    overview: "This is an example movie",
                    popularity: 123.45,
                    posterPath: "/example_poster_path.jpg",
                    releaseDate: "2023-12-01",
                    title: "Example Movie",
                    video: false,
                    voteAverage: 7.8,
                    voteCount: 100,
                    imageData: nil,
                    movieType: .topRated
                )
            ],
            totalPages: 2,
            totalResults: 20
        )
    }
}
