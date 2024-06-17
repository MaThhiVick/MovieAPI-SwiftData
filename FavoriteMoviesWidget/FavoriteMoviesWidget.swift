//
//  FavoriteMoviesWidget.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import WidgetKit
import SwiftUI
import Common
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

struct MovieEntry: TimelineEntry {
    var date: Date
    let title: String
    let image: Data
    let id: Int?
}

struct FavoriteMoviesWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if let id = entry.id {
            ZStack {
                Image(uiImage: UIImage().dataConvert(data: entry.image))
                    .resizable()
                    .scaleEffect(1.3)
                    .widgetURL(URL(string: "movieapi:favoriteMovie?id=\(id)")!)
            }
        } else {
            VStack {
                Text("Add some movie as favorite")
            }
        }
    }
}

struct FavoriteMoviesWidget: Widget {
    let kind: String = "FavoriteMoviesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            FavoriteMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Favorite Movies")
        .description("Shows your favorite movies")
        .supportedFamilies([.systemSmall])
    }
}

extension UIImage {
    func dataConvert(data: Data?) -> UIImage {
        guard let data, let uiImage = UIImage(data: data) else {
            return UIImage(systemName: "photo")!
        }
        return uiImage
    }
}

//#Preview(as: .systemSmall) {
//    FavoriteMoviesWidget()
//} timeline: {
//    MovieEntry(date: .now)
//}
