//
//  MovieAPI_SwiftDataApp.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI
import SwiftData
import class Common.FavoriteMovieIdentification

@main
struct MovieAPI_SwiftDataApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: FavoriteMovieIdentification.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    var body: some Scene {
        WindowGroup {
            if NSClassFromString("XCTestCase") != nil {
                EmptyView()
            } else {
                MovieListView(viewModel: MovieListViewModel(modelContext: modelContainer.mainContext))
                    .modelContainer(modelContainer)
            }
        }
    }
}
