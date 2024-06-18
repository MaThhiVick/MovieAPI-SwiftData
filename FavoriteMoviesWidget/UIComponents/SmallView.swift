//
//  SmallView.swift
//  FavoriteMoviesWidgetExtension
//
//  Created by Matheus Vicente on 17/06/24.
//

import SwiftUI

struct SmallView: View {
    let id: Int
    let imageData: Data

    var body: some View {
        ZStack {
            Image(uiImage: UIImage().dataConvert(data: imageData))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(1.2)
                .widgetURL(URL(string: "movieapi:favoriteMovie?id=\(id)")!)
        }
        .containerBackground(for: .widget) {
            Color.black
        }
    }
}

#Preview {
    SmallView(id: 0, imageData: Data())
}
