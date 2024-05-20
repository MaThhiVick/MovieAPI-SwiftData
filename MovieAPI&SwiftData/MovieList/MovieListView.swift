//
//  ContentView.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import SwiftUI
import NetworkService

struct MovieListView: View {
    @Query var movies: [FavoriteMovieID]
    @Environment(\.modelContext) var context
    @ObservedObject var viewModel: MovieListViewModel
    @State private var index = 0
    private let frameHeight: CGFloat = 500

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: .none) {
                    Text("Top rated")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 32)
                        .padding(.leading, 8)
                    TabView(selection: $index) {
                            ForEach(viewModel.topRatedList, id: \.self) { movie in
                                NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                                MovieCard(
                                    image: UIImage().dataConvert(
                                        data: movie.imageData
                                    ),
                                    isFavorite: true,
                                    cardSize: .big
                                )
                            }
                        }
                    }
                    .padding(.top, -12)
                    .frame(height: frameHeight)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    Carousel(items: $viewModel.popularList, title: "Popular") { index, movie  in
                        NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                            MovieCard(
                                image: UIImage().dataConvert(data: movie.imageData),
                                isFavorite: true,
                                cardSize: .small
                            )
                        }
                    }
                    .padding(.top, 32)

                    Carousel(items: $viewModel.favoritesMovies, title: "Favorite") { index, movie in
                        NavigationLink(destination: MovieDetailView(movieInformation: movie)) {
                            MovieCard(
                                image: UIImage().dataConvert(data: movie.imageData),
                                isFavorite: true,
                                cardSize: .small
                            )
                        }
                    }
                    .padding(.top, 32)

                }
                .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
                .onAppear {
                    Task  {
                        await viewModel.getAllListMovies()
                    }
                }
            }
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
