//
//  MovieListViewModelTests.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import SwiftData
import XCTest
import Common
@testable import MovieAPI_SwiftData

final class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var movieProvider: MovieDataProviderMock!

    @MainActor
    override func setUpWithError() throws {
        movieProvider = MovieDataProviderMock()
        sut = MovieListViewModel(
            movieProvider: movieProvider,
            modelContext: try! setupModelContext().mainContext
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        movieProvider = nil
    }

    func setupModelContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try ModelContainer(for: FavoriteMovieIdentification.self, configurations: config)
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
        sut.topRatedList = MovieResponseModelMock.getMovieResponse()
        sut.favoriteAction(fromMovie: sut.topRatedList[0], at: 0)

        XCTAssertTrue(sut.topRatedList[0].isFavorite!)
        XCTAssertTrue(sut.favoritesMovies[0].isFavorite!)
    }

    func testFavoriteAction_whenUnfavoriteAMovie_theMovieShouldHaveIsFavoriteFalse() {
        sut.topRatedList = MovieResponseModelMock.getMovieResponse()
        sut.topRatedList[0].isFavorite = true
        sut.favoriteAction(fromMovie: sut.topRatedList[0], at: 0)

        XCTAssertFalse(sut.topRatedList[0].isFavorite!)
        XCTAssertTrue(sut.favoritesMovies.isEmpty)
    }

    func testHandleUrl_whenUrlIsValid_shouldShowDetailView() {
        let movie = MovieResponseModelMock.getMovieResponse().first!
        let url = URL(string: "movieapi:favoriteMovie?id=\(movie.id)")!
        sut.isLoading = false
        sut.favoritesMovies.append(movie)

        sut.handle(url: url)

        XCTAssertEqual(sut.selectedFavoriteId, movie.id)
        XCTAssertTrue(sut.showDetailView)
    }
}
