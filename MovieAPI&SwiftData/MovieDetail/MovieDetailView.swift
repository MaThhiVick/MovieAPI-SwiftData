//
//  MovieDetailView.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import SwiftUI

struct MovieDetailView: View {
    @Query var movies: [FavoriteMovieInformation]
    @Environment(\.modelContext) var context
    @ObservedObject private var viewModel: MovieDetailViewModel

    init(movieInformation: Movie) {
        viewModel = MovieDetailViewModel(movieInformation: movieInformation)
    }

    var body: some View {
        ScrollView( .vertical) {
            VStack(alignment: .leading, spacing: .none) {
                MovieCard(
                    image: UIImage().dataConvert(
                        data: viewModel.movieInformation.imageData
                    ),
                    isFavorite: viewModel.movieInformation.isFavorite ?? false,
                    cardSize: .big
                ) {
                    if viewModel.movieInformation.isFavorite ?? false {
                        if let objectToDelete = movies.first(where: { $0.id == viewModel.movieInformation.id }) {
                            context.delete(objectToDelete)
                        }
                        viewModel.movieInformation.isFavorite = false
                } else {
                        context.insert(
                            FavoriteMovieInformation(
                                id: viewModel.movieInformation.id,
                                movieType: viewModel.movieInformation.movieType ?? .topRated
                            )
                        )
                        viewModel.movieInformation.isFavorite = true
                    }
                }
                .frame(height: 600)
                .ignoresSafeArea(edges: .top)
                VStack(alignment: .center, spacing: 8) {
                    Text(viewModel.movieDetail?.originalTitle ?? "")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding(.top, 8)

                    HStack(spacing: 16) {
                        Text("\(viewModel.movieDetail?.runtime ?? 0)min")
                            .font(.caption2)
                            .foregroundStyle(.gray)

                        Text("\(viewModel.movieDetail?.genres.first?.name ?? "")")
                            .font(.caption2)
                            .foregroundStyle(.gray)

                        Text("\(viewModel.movieDetail?.releaseDate ?? "0")")
                            .font(.caption2)
                            .foregroundStyle(.gray)

                    }

                    informationSection()
                        .padding(.horizontal, 8)
                }
            }
        }

        .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
        .onAppear {
            Task {
                await viewModel.getMovieDetail()
            }
        }
    }

    @ViewBuilder
    func informationSection() -> some View {
        InformationMovie(title: "Overview", information: viewModel.movieDetail?.overview ?? "Not informed")

        InformationMovie(
            title: "Average",
            information: "\(viewModel.movieDetail?.voteAverage ?? 0)"
        )

        InformationMovie(
            title: "Popularity",
            information: "\(viewModel.movieDetail?.popularity ?? 0)"
        )

        InformationMovie(
            title: "Run time",
            information: "\(viewModel.movieDetail?.runtime ?? 0)min"
        )

        InformationMovie(
            title: "Release date",
            information: viewModel.movieDetail?.releaseDate ?? "Not informed"
        )

        Link("Web page", destination: URL(string: viewModel.movieDetail?.homepage ?? "") ?? URL(string: "https://www.imdb.com")!)
    }
}
