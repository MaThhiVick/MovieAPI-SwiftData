//
//  FavoriteMovieID.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData

@Model
class FavoriteMovieID: Hashable {
    @Attribute(.unique) var id: Int

    init(id: Int) {
        self.id = id
    }
}
