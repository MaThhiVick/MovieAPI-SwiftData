//
//  ContentView.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import SwiftUI
import Common

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var tabBarPosition = 0
    private let frameHeight: CGFloat = 500
    @State private var favoriteId: Int?
    @State private var shouldPresentDetail = false

    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: .none) {
                    topRatedSection()
                    carouselSection(movieList: $viewModel.popularList, title: "Popular")
                    carouselSection(movieList: $viewModel.favoritesMovies, title: "Favorite movies")
                }

            }
            .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
            .onAppear {
                Task  {
                    await viewModel.getAllListMovies()
                }
            }
            NavigationLink(
                destination: MovieDetailView(movieInformation: viewModel.favoritesMovies.filter {
                    $0.id == favoriteId
                }.first ?? Movie.create(id: 0000, title: "tset", overview: "test"),
                                             modelContext: viewModel.modelContext,
                                             favoriteMovieInformation: viewModel.favoriteMoviesInformation),
                isActive: $shouldPresentDetail
            ) {
                EmptyView()
            }.hidden()

        }
        .onOpenURL { url in
            if let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
               let queryItems = urlComponents.queryItems,
               let idItem = queryItems.first(where: { $0.name == "id" }),
               let id = Int(idItem.value ?? "") {
                if let movie = viewModel.favoritesMovies.filter { $0.id == id }.first {
                    favoriteId = id
                    shouldPresentDetail = true
                }
            }
        }
    }

    @ViewBuilder
    func topRatedSection() -> some View {
        Text("Top rated")
            .font(.largeTitle)
            .bold()
            .padding(.top, 32)
            .padding(.leading, 8)
        TabView(selection: $tabBarPosition) {
            ForEach(Array(viewModel.topRatedList.enumerated()), id: \.element) { index, movie in
                NavigationLink(destination: MovieDetailView(movieInformation: movie,
                                                            modelContext: viewModel.modelContext,
                                                            favoriteMovieInformation: viewModel.favoriteMoviesInformation)) {
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
    }

    @ViewBuilder
    func carouselSection(movieList: Binding<[Movie]> , title: String) -> some View {
        Carousel(items: movieList, title: title) { index, movie in
            NavigationLink(destination: MovieDetailView(movieInformation: movie,
                                                        modelContext: viewModel.modelContext,
                                                        favoriteMovieInformation: viewModel.favoriteMoviesInformation)) {
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
