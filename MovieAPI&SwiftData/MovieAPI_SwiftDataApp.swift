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

    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel())
        }
    }
}
