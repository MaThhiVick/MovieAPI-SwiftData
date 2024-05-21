//
//  MovieAPI_SwiftDataApp.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI
import SwiftData

@main
struct MovieAPI_SwiftDataApp: App {
    let modelContainer: ModelContainer
      init() {
        do {
          modelContainer = try ModelContainer(for: FavoriteMovieInformation.self)
        } catch {
          fatalError("Could not initialize ModelContainer")
        }
      }

    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel())
                .modelContainer(modelContainer)
        }
    }
}
