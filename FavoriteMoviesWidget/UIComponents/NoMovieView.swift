//
//  NoMovieView.swift
//  FavoriteMoviesWidgetExtension
//
//  Created by Matheus Vicente on 17/06/24.
//

import SwiftUI

struct NoMovieView: View {
    var body: some View {
        VStack {
            Text("Add some movie as favorite")
        }
        .containerBackground(for: .widget) {}
    }
}

#Preview {
    NoMovieView()
}
