//
//  FavoriteMoviesWidget.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import WidgetKit
import SwiftUI

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
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image(uiImage: entry.image!)
                .resizable()
                .scaledToFill()

            Text(entry.title)
                .bold()
                .foregroundColor(.yellow)
                .shadow(radius: 3)
                .padding(.top, 100)
                .padding(.trailing, 90)
        }
    }
}

struct FavoriteMoviesWidget: Widget {
    let kind: String = "FavoriteMoviesWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, provider: Provider()) { entry in
            FavoriteMoviesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Favorite Movies")
        .description("Shows your favorite movies")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    FavoriteMoviesWidget()
} timeline: {
    MovieEntry(date: .now)
}
