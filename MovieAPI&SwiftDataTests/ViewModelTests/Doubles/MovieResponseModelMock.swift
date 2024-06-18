//
//  MovieResponseModelMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 18/06/24.
//

import Foundation
import struct Common.Movie

public struct MovieResponseModelMock {
    public static func getMovieResponse() -> [Movie] {
        return [
            Movie(
                adult: false,
                backdropPath: "test",
                genreIDs: [0],
                id: 01,
                originalLanguage: "english",
                originalTitle: "Movie",
                overview: "test",
                popularity: 1.0,
                posterPath: "test",
                releaseDate: "test",
                title: "test",
                video: false,
                voteAverage: 0,
                voteCount: 0
            )
        ]
    }
}
