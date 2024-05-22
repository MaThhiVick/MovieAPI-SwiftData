//
//  MovieDataProviderTests.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import XCTest
@testable import MovieAPI_SwiftData

final class MovieDataProviderTests: XCTestCase {
    var sut: MovieDataProvider!
    var networkService: MockNetworkUseCase!

    override func setUpWithError() throws {
        networkService = MockNetworkUseCase()
        sut = MovieDataProvider(networkRequest: networkService)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
    }

    func testGetMovie_successfulReturnFromNetwork_shouldReturnMovieResponse() async {
        let result = await sut.getMovies(from: .list(.popular))
        XCTAssertEqual(result, MovieResponseModel.getMovieResponse().movies)
    }

    func testGetMovie_receiveNilFromNetwork_shouldReturnNil() async {
        networkService.shouldReturnNil = true
        let result = await sut.getMovies(from: .list(.popular))
        XCTAssertTrue(result.isEmpty)
    }
}
