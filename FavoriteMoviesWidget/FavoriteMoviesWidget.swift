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
    let networkUseCase: NetworkRequestUseCase = NetworkUseCase()

    func placeholder(in context: Context) -> MovieEntry {
        MovieEntry(date: .now, title: "placehorder", image: Data(), id: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (MovieEntry) -> Void) {
        let entry = MovieEntry(date: .now, title: "Snapshot", image: Data(), id: 0)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MovieEntry>) -> Void) {
        Task {
            let favoriteMovies = await getFavoriteMovies()
            if let movieInformation = await getMovieData(fromId: favoriteMovies.last!.id) {
                completion(Timeline(entries: [movieInformation], policy: .atEnd))
            } else {
                completion(Timeline(entries: [MovieEntry(date: .now, title: "", image: Data(), id: 0)], policy: .atEnd))
            }
        }
    }

    func getMovieData(fromId id: Int) async -> MovieEntry? {
        guard let movieDetail: MovieDetailModel = await networkUseCase.request(urlMovie: .detail(id)),
              let imageData: Data = await networkUseCase.request(urlMovie: .image(movieDetail.posterPath))
        else {
            return nil
        }
        return MovieEntry(date: .now, title: movieDetail.originalTitle, image: imageData, id: id)
    }

    func getFavoriteMovies() async -> [FavoriteMovieInformations] {
        do {
            let modelContainer = try await ModelContainer(for: FavoriteMovieInformations.self).mainContext
            let descriptor = FetchDescriptor<FavoriteMovieInformations>()
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
    let id: Int
}

struct FavoriteMoviesWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image(uiImage: UIImage().dataConvert(data: entry.image))
                .resizable()
                .scaleEffect(1.3)
                .widgetURL(URL(string: "movieapi:favoriteMovie?id=\(entry.id)")!)
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
