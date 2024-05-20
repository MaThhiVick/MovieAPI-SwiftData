//
//  Bookmark.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI

struct BookmarkIcon: View {
    @Binding var isFavorite: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 24, height: 30)
                .foregroundStyle(isFavorite ? .yellow : .gray.opacity(0.5))

            Image(systemName: isFavorite ? "checkmark" : "plus")
                .foregroundStyle(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
