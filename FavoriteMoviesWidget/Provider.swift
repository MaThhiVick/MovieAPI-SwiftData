//
//  Provider.swift
//  FavoriteMoviesWidgetExtension
//
//  Created by Matheus Vicente on 17/06/24.
//

import Common
import WidgetKit
import SwiftData

struct Provider: TimelineProvider {
    private let networkUseCase: NetworkRequestUseCase

    init(networkUseCase: NetworkRequestUseCase = NetworkUseCase()) {
        self.networkUseCase = networkUseCase
    }

    func placeholder(in context: Context) -> MovieEntry {
        MovieEntry(date: .now, title: "placehorder", image: Data(), id: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (MovieEntry) -> Void) {
        let entry = MovieEntry(date: .now, title: "Snapshot", image: Data(), id: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MovieEntry>) -> Void) {
        Task {
            let favoriteMovies = await getFavoriteMovies()

            if let lastMovie = favoriteMovies.last,
               let movieInformation = await getMovieData(fromId: lastMovie.id) {
                completion(Timeline(entries: [movieInformation], policy: .atEnd))
            } else {
                completion(Timeline(entries: [MovieEntry(date: .now, title: "", image: Data(), id: nil)], policy: .atEnd))
            }
        }
    }

    private func getMovieData(fromId id: Int) async -> MovieEntry? {
        guard let movieDetail: MovieDetailModel = await networkUseCase.request(urlMovie: .detail(id)),
             let imageData: Data = await networkUseCase.request(urlMovie: .image(movieDetail.posterPath))
        else {
            return nil
        }
        return MovieEntry(date: .now, title: movieDetail.originalTitle, image: imageData, id: id)
    }

    private func getFavoriteMovies() async -> [FavoriteMovieIdentification] {
        do {
            let modelContainer = try await ModelContainer(for: FavoriteMovieIdentification.self).mainContext
            let descriptor = FetchDescriptor<FavoriteMovieIdentification>()
            let fetchedData = try? modelContainer.fetch(descriptor)
            guard let fetchedData else {
                return []
            }
            return fetchedData
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
}
