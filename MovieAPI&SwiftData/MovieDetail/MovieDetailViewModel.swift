//
//  MovieDetailViewModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import Common
import SwiftUI
import WidgetKit

class MovieDetailViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase
    @Published var movieInformation: Movie?
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading = true
    @Published var modelContext: ModelContext
    @Published var favoriteMoviesInformation = [FavoriteMovieIdentification]()

    init(
        networkService: NetworkRequestUseCase = NetworkUseCase(),
        movieInformation: Movie?,
        modelContext: ModelContext,
        favoriteMoviesInformation: [FavoriteMovieIdentification]
    ) {
        self.networkService = networkService
        self.movieInformation = movieInformation
        self.modelContext = modelContext
        self.favoriteMoviesInformation = favoriteMoviesInformation
    }

    @MainActor
    func getMovieDetail() async {
        guard let result: MovieDetailModel = await networkService.request(urlMovie: .detail(self.movieInformation?.id ?? 0)) else {
            return
        }
        movieDetail = result
        isLoading = false
    }

    func favoriteAction() {
        defer {
            WidgetCenter.shared.reloadAllTimelines()
        }

        if movieInformation?.isFavorite ?? false {
            movieInformation?.isFavorite = false
            if let objectToDelete = favoriteMoviesInformation.first(where: { $0.id == movieInformation?.id ?? 0 }) {
                modelContext.delete(objectToDelete)
            }
        } else {
            movieInformation?.isFavorite = true
            modelContext.insert(
                FavoriteMovieIdentification(
                    id: movieInformation?.id ?? 0,
                    movieType: movieInformation?.movieType ?? .topRated
                )
            )
        }
    }
}
