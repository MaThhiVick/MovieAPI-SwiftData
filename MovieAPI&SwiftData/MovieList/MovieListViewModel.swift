//
//  MovieListViewModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import Common
import SwiftUI
import WidgetKit

final class MovieListViewModel: ObservableObject {
    let movieProvider: MovieDataProviderProtocol
    @Published var modelContext: ModelContext
    @Published var favoriteMoviesInformation = [FavoriteMovieInformations]()
    @Published var topRatedList = [Movie]()
    @Published var popularList = [Movie]()
    @Published var favoritesMovies = [Movie]()
    @Published var isLoading = true
    @Published var shouldPresentDetail = false

    init(movieProvider: MovieDataProviderProtocol = MovieDataProvider(),
         modelContext: ModelContext) {
        self.movieProvider = movieProvider
        self.modelContext = modelContext
    }

    @MainActor
    func getAllListMovies(shouldPresentDetailFromView: Bool) async {
        topRatedList = await movieProvider.getMovies(from: .list(.topRated))
        popularList = await movieProvider.getMovies(from: .list(.popular))
        fetchData()
        favoriteMovieSetup(favoriteMoviesInformation)
        isLoading = false
        if shouldPresentDetailFromView {
            shouldPresentDetail = true
        }
    }

    private func favoriteMovieSetup(_ idList: [FavoriteMovieInformations]) {
        favoritesMovies = []
        isTheseMovies(&topRatedList, favorite: idList)
        isTheseMovies(&popularList, favorite: idList)
    }

    private func isTheseMovies(_ movies: inout [Movie], favorite: [FavoriteMovieInformations]) {
        let favoriteMoviesId = Set(favorite.map { $0.id })

        for index in movies.indices where favoriteMoviesId.contains(movies[index].id) {
            movies[index].isFavorite = true
            self.favoritesMovies.appendIfNotContains(movies[index])
        }
    }

    private func addToFavoriteMovie(movie: Movie, at index: Int) {
        switch movie.movieType ?? .topRated {
        case .topRated:
            for index in topRatedList.indices where topRatedList[index].id == movie.id {
                topRatedList[index].isFavorite = true
                favoritesMovies.appendIfNotContains(topRatedList[index])
            }
        case .popular:
            for index in popularList.indices where popularList[index].id == movie.id {
                popularList[index].isFavorite = true
                favoritesMovies.appendIfNotContains(popularList[index])
            }
        }
    }

    private func removeFavoriteMovieBy(id: Int, fromList movieType: MovieListType) {
        switch movieType {
        case .topRated:
            for index in topRatedList.indices where topRatedList[index].id == id {
                topRatedList[index].isFavorite = false
            }
        case .popular:
            for index in popularList.indices where popularList[index].id == id {
                popularList[index].isFavorite = false
            }
        }
    }

    func favoriteAction(fromMovie movie: Movie, at index: Int) {
        defer {
            WidgetCenter.shared.reloadAllTimelines()
        }
        if movie.isFavorite ?? false {
            favoritesMovies.removeAll(where: { $0.id == movie.id })
            removeFavoriteMovieBy(id: movie.id, fromList: movie.movieType ?? . topRated)
            if let objectToDelete = favoriteMoviesInformation.first(where: {
                $0.id == movie.id
            }) {
                modelContext.delete(objectToDelete)
            }
        } else {
            modelContext.insert(
                FavoriteMovieInformations(
                    id: movie.id,
                    movieType: movie.movieType ?? .topRated,
                    title: movie.title,
                    imageData: movie.imageData ?? Data()
                )
            )
            addToFavoriteMovie(movie: movie, at: index)
        }
    }

    private func fetchData() {
        do {
            let descriptor = FetchDescriptor<FavoriteMovieInformations>()
            favoriteMoviesInformation = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
