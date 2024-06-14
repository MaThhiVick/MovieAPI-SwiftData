//
//  FavoriteMoviesWidgetBundle.swift
//  FavoriteMoviesWidget
//
//  Created by Matheus Vicente on 13/06/24.
//

import WidgetKit
import SwiftUI
import SwiftData

@main
struct FavoriteMoviesWidgetBundle: WidgetBundle {
//    let modelContainer: ModelContainer
//      init() {
//        do {
//          modelContainer = try ModelContainer(for: FavoriteMovieInformation.self)
//        } catch {
//          fatalError("Could not initialize ModelContainer")
//        }
//      }

    var body: some Widget {
        FavoriteMoviesWidget()
    }
}
