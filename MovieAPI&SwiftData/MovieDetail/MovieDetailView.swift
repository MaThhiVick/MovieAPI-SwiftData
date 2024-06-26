//
//  MovieDetailView.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import SwiftData
import SwiftUI
import struct Common.Movie
import class Common.FavoriteMovieIdentification

struct MovieDetailView: View {
    @ObservedObject private var viewModel: MovieDetailViewModel

    init(
        movieInformation: Movie?,
        modelContext: ModelContext,
        favoriteMovieInformation: [FavoriteMovieIdentification]
    ) {
        viewModel = MovieDetailViewModel(
            movieInformation: movieInformation,
            modelContext: modelContext,
            favoriteMoviesInformation: favoriteMovieInformation
        )
    }

    var body: some View {
        ScrollView( .vertical) {
            VStack(alignment: .leading, spacing: .none) {
                movieCard()
                VStack(alignment: .center, spacing: 12) {
                    subheader()
                    informationSection()
                        .padding(.horizontal, 8)
                }
            }
        }
        .redacted(reason: $viewModel.isLoading.wrappedValue == true ? .placeholder : [])
        .task {
            await viewModel.getMovieDetail()
        }
    }

    @ViewBuilder
    func movieCard() -> some View {
        MovieCard(
            image: UIImage().dataConvert(
                data: viewModel.movieInformation?.imageData
            ),
            isFavorite: viewModel.movieInformation?.isFavorite ?? false,
            cardSize: .big
        ) {
            viewModel.favoriteAction()
        }
        .frame(height: 600)
        .ignoresSafeArea(edges: .top)
    }

    @ViewBuilder
    func subheader() -> some View {
        Text(viewModel.movieDetail?.title ?? "")
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
    }

    @ViewBuilder
    func informationSection() -> some View {
        InformationMovie(
            title: "overview",
            information: viewModel.movieDetail?.overview ?? "not_informed"
        )

        InformationMovie(
            title: "average",
            information: "\(viewModel.movieDetail?.voteAverage ?? 0)"
        )

        InformationMovie(
            title: "popularity",
            information: "\(viewModel.movieDetail?.popularity ?? 0)"
        )

        InformationMovie(
            title: "run_time",
            information: "\(viewModel.movieDetail?.runtime ?? 0)min"
        )

        InformationMovie(
            title: "release_date",
            information: viewModel.movieDetail?.releaseDate ?? "not_informed"
        )

        Link("web_page", destination: URL(string: viewModel.movieDetail?.homepage ?? "") ?? URL(string: "https://www.imdb.com")!)
    }
}
