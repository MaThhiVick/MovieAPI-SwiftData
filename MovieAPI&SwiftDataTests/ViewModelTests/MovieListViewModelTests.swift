//
//  MovieListViewModelTests.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import SwiftData
import XCTest
@testable import MovieAPI_SwiftData

final class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var networkService: MockNetworkUseCase!
    var movieProvider: MovieDataProviderMock!

    @MainActor
    override func setUpWithError() throws {
        networkService = MockNetworkUseCase()
        movieProvider = MovieDataProviderMock()
        sut = MovieListViewModel(
            movieProvider: movieProvider,
            networkService: networkService,
            modelContext: try! setupModelContext().mainContext
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        networkService = nil
        movieProvider = nil
    }

    func setupModelContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(for: FavoriteMovieInformations.self, configurations: config)
    }

    @MainActor
    func testGetAllListMovies_whenCallFunction_shouldAddLists() async {
        let expectation = expectation(description: "get all list")

        Task {
            await sut.getAllListMovies()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation])

        XCTAssertFalse(sut.topRatedList.isEmpty)
        XCTAssertTrue(sut.favoritesMovies.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }

    func testFavoriteAction_whenFavoriteAMovie_theMovieShouldHaveIsFavoriteTrue() {
        sut.topRatedList = MovieResponseModel.getMovieResponse().movies
        sut.favoriteAction(fromMovie: sut.topRatedList[0], at: 0)

        XCTAssertTrue(sut.topRatedList[0].isFavorite!)
        XCTAssertTrue(sut.favoritesMovies[0].isFavorite!)
    }

    func testFavoriteAction_whenUnfavoriteAMovie_theMovieShouldHaveIsFavoriteFalse() {
        sut.topRatedList = MovieResponseModel.getMovieResponse().movies
        sut.topRatedList[0].isFavorite = true
        sut.favoriteAction(fromMovie: sut.topRatedList[0], at: 0)

        XCTAssertFalse(sut.topRatedList[0].isFavorite!)
        XCTAssertTrue(sut.favoritesMovies.isEmpty)
    }
}
