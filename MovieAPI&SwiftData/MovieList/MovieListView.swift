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
    @ObservedObject var viewModel: MovieListViewModel
    @State private var tabBarPosition = 0
    private let frameHeight: CGFloat = 500

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: .none) {
                    Text("Top rated")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 32)
                        .padding(.leading, 8)
                    TabView(selection: $tabBarPosition) {
                        ForEach(Array(viewModel.topRatedList.enumerated()), id: \.element) { index, movie in
                            NavigationLink(destination: MovieDetailView(movieInformation: movie, modelContext: viewModel.modelContext, favoriteMovieInformation: viewModel.favoriteMoviesInformation)) {
                                MovieCard(
                                    image: UIImage().dataConvert(
                                        data: movie.imageData
                                    ),
                                    isFavorite: movie.isFavorite ?? false,
                                    cardSize: .big
                                ) {
                                    viewModel.favoriteAction(fromMovie: movie, at: index)
                                }
                            }.tag(index)
                        }
                    }
                    .padding(.top, -12)
                    .frame(height: frameHeight)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    Carousel(items: $viewModel.popularList, title: "Popular") { index, movie  in
                        NavigationLink(destination: MovieDetailView(movieInformation: movie, modelContext: viewModel.modelContext, favoriteMovieInformation: viewModel.favoriteMoviesInformation)) {
                            MovieCard(
                                image: UIImage().dataConvert(data: movie.imageData),
                                isFavorite: movie.isFavorite ?? false,
                                cardSize: .small
                            ) { viewModel.favoriteAction(fromMovie: movie, at: index) }
                        }
                    }
                    .padding(.top, 32)

                    Carousel(items: $viewModel.favoritesMovies, title: "Favorite") { index, movie in
                        NavigationLink(destination: MovieDetailView(movieInformation: movie, modelContext: viewModel.modelContext, favoriteMovieInformation: viewModel.favoriteMoviesInformation)) {
                            MovieCard(
                                image: UIImage().dataConvert(data: movie.imageData),
                                isFavorite: movie.isFavorite ?? false,
                                cardSize: .small
                            ) {
                                viewModel.favoriteAction(fromMovie: movie, at: index)
                            }
                        }
                    }
                    .padding(.top, 32)
                }

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

//#Preview {
//    MovieListView(viewModel: MovieListViewModel())
//}
