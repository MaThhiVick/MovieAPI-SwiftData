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
    @State var isFavorite: Bool
    let cardSize: MovieCardType
    let buttonAction: () -> Void

    init(
        image: UIImage,
        isFavorite: Bool,
        cardSize: MovieCardType,
        buttonAction: @escaping () -> Void
    ) {
        self.image = image
        self.isFavorite = isFavorite
        self.cardSize = cardSize
        self.buttonAction = buttonAction
    }

    var body: some View {
        VStack(spacing: .none) {
            if cardSize == .big {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                    Button(action: {
                        isFavorite.toggle()
                        buttonAction()
                    }, label: {
                        BookmarkIcon(isFavorite: $isFavorite)
                            .padding(.trailing, 12)
                            .padding(.top, 12)
                            .scaleEffect(1.6)
                    })

                }
            } else {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 170)
                    Button(action: {
                        isFavorite.toggle()
                        buttonAction()
                    }, label: {
                        BookmarkIcon(isFavorite: $isFavorite)
                    })
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
