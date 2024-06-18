//
//  MovieEntry.swift
//  FavoriteMoviesWidgetExtension
//
//  Created by Matheus Vicente on 17/06/24.
//

import WidgetKit

struct MovieEntry: TimelineEntry {
    var date: Date
    let title: String
    let image: Data
    let id: Int?
}
