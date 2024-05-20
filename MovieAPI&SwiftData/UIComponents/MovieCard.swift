//
//  MovieCard.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI

enum MovieCardType {
    case big
    case small
}

struct MovieCard: View {
    @State var image: UIImage
    let cardSize: MovieCardType

    init(
        image: UIImage,
        cardSize: MovieCardType
    ) {
        self.image = image
        self.cardSize = cardSize
    }

    var body: some View {
        VStack(spacing: .none) {
            if cardSize == .big {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                }
            } else {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 170)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
