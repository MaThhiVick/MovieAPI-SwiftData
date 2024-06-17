//
//  FavoriteMoviesWidget.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import WidgetKit
import SwiftUI

struct FavoriteMoviesWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            if let id = entry.id {
                SmallView(id: id, imageData: entry.image)
            } else {
                NoMovieView()
            }
        case .systemMedium:
            if let id = entry.id {
                MediumView(movieEntry: entry, id: id)
            } else {
                NoMovieView()
            }
        default:
            fatalError()
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemMedium) {
    FavoriteMoviesWidget()
} timeline: {
    MovieEntry(date: .now, title: "Kingdon of the Planet of the apple", image: Data(), id: 0)
    MovieEntry(date: .now, title: "Movie", image: Data(), id: nil)
}
