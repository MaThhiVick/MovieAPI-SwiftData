//
//  MovieListViewModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

final class MovieListViewModel: ObservableObject {
    let movieProvider: MovieDataProviderProtocol
    let networkService: NetworkRequestUseCase
    @Published var topRatedList = [Movie]()
    @Published var popularList = [Movie]()
    @Published var favoritesMovies = [Movie]()
    @Published var isLoading = true

    init(movieProvider: MovieDataProviderProtocol = MovieDataProvider(),
         networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.movieProvider = movieProvider
        self.networkService = networkService
    }

    @MainActor
    func getAllListMovies(andFavoriteMovies idList: [FavoriteMovieID]) async {
        Task {
            topRatedList = await movieProvider.getMovies(from: .list(.topRated))
            popularList = await movieProvider.getMovies(from: .list(.popular))
            favoriteMovieSetup(idList)
            isLoading = false
        }
    }

    func addMovieFavorite(from movieList: inout [Movie], at index: Int) {
        movieList[index].isFavorite = true
        favoritesMovies.appendIfNotContains(movieList[index])
    }

    func favoriteMovieSetup(_ idList: [FavoriteMovieID]) {
        favoritesMovies = []
        isTheseMovies(&topRatedList, favorite: idList)
        isTheseMovies(&popularList, favorite: idList)
    }

    private func isTheseMovies(_ movies: inout [Movie], favorite: [FavoriteMovieID]) {
        let favoriteMoviesId = Set(favorite.map { $0.id })

        for index in movies.indices where favoriteMoviesId.contains(movies[index].id) {
            movies[index].isFavorite = true
            self.favoritesMovies.appendIfNotContains(movies[index])
        }
    }
}
