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

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> MovieEntry {
        MovieEntry(date: Date())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> MovieEntry {
        MovieEntry(date: Date())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<MovieEntry> {
        var entries: [MovieEntry] = []

        // remove
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = MovieEntry(date: entryDate)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct MovieEntry: TimelineEntry {
    var date: Date
    let title: String = "Movie"
    let image = UIImage(systemName: "photo")
}

struct FavoriteMoviesWidgetEntryView : View {
    @Environment(\.modelContext) var context
    @Query var movies: [FavoriteMovieInformations]
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image(uiImage: UIImage().dataConvert(data: movies.last!.imageData)) // change last
                .resizable()
                .scaleEffect(1.3)
                .widgetURL(URL(string: "movieapi:favoriteMovie?id=\(movies.last!.id)")!)
        }
    }
}

struct FavoriteMoviesWidget: Widget {
    let kind: String = "FavoriteMoviesWidget"

    let modelContainer: ModelContainer
      init() {
        do {
          modelContainer = try ModelContainer(for: FavoriteMovieInformations.self)
        } catch {
          fatalError("Could not initialize ModelContainer")
        }
      }

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            FavoriteMoviesWidgetEntryView(entry: entry)
                .modelContainer(modelContainer)
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
