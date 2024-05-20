//
//  Carousel.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftUI

struct Carousel<Model: Hashable, Content: View>: View {
    @Binding var items: [Model]
    var content: (Int, Model) -> Content
    var title: String

    init(
        items: Binding<[Model]>,
        title: String,
        content: @escaping (Int, Model) -> Content
    ) {
        self._items = items
        self.content = content
        self.title = title
    }

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .padding(.leading, 8)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 5) {
                    ForEach(Array(items.enumerated()), id: \.element) { index, movie in
                        content(index, movie)
                    }
                }
            }
        }
    }
}
