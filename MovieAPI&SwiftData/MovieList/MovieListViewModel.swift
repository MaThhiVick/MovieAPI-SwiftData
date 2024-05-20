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
    @Published var isLoading = true

    init(movieProvider: MovieDataProviderProtocol = MovieDataProvider(),
         networkService: NetworkRequestUseCase = NetworkUseCase()) {
        self.movieProvider = movieProvider
        self.networkService = networkService
    }

    @MainActor
    func getAllListMovies() async {
        Task {
            topRatedList = await movieProvider.getMovies(from: .list(.topRated))
            popularList = await movieProvider.getMovies(from: .list(.popular))
            isLoading = false
        }
    }
}
