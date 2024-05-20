//
//  MovieDetailViewModel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    let networkService: NetworkRequestUseCase
    @Published var movieInformation: Movie
    @Published var movieDetail: MovieDetailModel?
    @Published var isFavoriteMovie = true
    @Published var isLoading = true

    init(
        networkService: NetworkRequestUseCase = NetworkUseCase(),
        movieInformation: Movie
    ) {
        self.networkService = networkService
        self.movieInformation = movieInformation
    }

    @MainActor
    func getMovieDetail() async {
        guard let result: MovieDetailModel = await networkService.request(urlMovie: .detail(self.movieInformation.id)) else {
            return
        }
        movieDetail = result
        isLoading = false
    }
}
