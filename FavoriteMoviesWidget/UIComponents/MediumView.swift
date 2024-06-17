//
//  MediumView.swift
//  FavoriteMoviesWidgetExtension
//
//  Created by Matheus Vicente on 17/06/24.
//

import SwiftUI

struct MediumView: View {
    let title: String
    let imageData: Data
    let id: Int

    init(movieEntry: MovieEntry, id: Int) {
        title = movieEntry.title
        imageData = movieEntry.image
        self.id = id
    }

    var body: some View {
        HStack {
            Text(title)
                .frame(maxWidth: 180)
            Spacer()
            Image(uiImage: UIImage().dataConvert(data: imageData))
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .scaleEffect(0.7)
                .widgetURL(URL(string: "movieapi:favoriteMovie?id=\(id)")!)
        }
        .containerBackground(for: .widget) {}
    }
}

#Preview {
    MediumView(movieEntry: MovieEntry(date: .now, title: "movie", image: Data(), id: 0), id: 0)
}
