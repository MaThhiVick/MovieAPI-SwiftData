//
//  AppIntent.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import WidgetKit
import AppIntents

//"Implement a widget displaying the latest favorite movie with poster image and movie title. Support deep-link navigation from widget to detailed view of the movie."
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
