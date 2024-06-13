//
//  URLProvider.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation

protocol URLProvider {
    func getURLMovie(from urlType: URLMoviesType) -> URL?
    func getNetworkHeaders() -> [String: String]
}

final class DefaultURLProvider: URLProvider {
    let movieHeader: String
    let urlMovies: String
    let bundle: Bundle

    init(movieHeader: String = NetworkConstants.movieHeader,
         urlMovies: String = NetworkConstants.urlMovies,
         bundle: Bundle = Bundle.main) {
        self.movieHeader = movieHeader
        self.urlMovies = urlMovies
        self.bundle = bundle
    }

    func getNetworkHeaders() -> [String: String] {
        guard let header = bundle.object(forInfoDictionaryKey: movieHeader) as? [String: String] else {
            return [:]
        }
        return header
    }

    func getURLMovie(from urlType: URLMoviesType) -> URL? {
        if let defaultUrl = getDefaultURL(fromMovie: urlType) {
            switch urlType {
            case .detail(let id):
                return insert(movieId: id, to: defaultUrl)
            case .image(let path):
                return defaultUrl.appendingPathComponent(path)
            case .list(let path):
                return defineMovieList(from: path, to: defaultUrl)
            }
        }
        return nil
    }

    private func defineMovieList(from path: MovieListType, to url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let newPath = url.path.replacingOccurrences(of: "TYPE", with: "\(path.rawValue)")
        components.path = newPath

        return components.url
    }

    private func insert(movieId: Int, to url: URL) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }

        let newPath = url.path.replacingOccurrences(of: "MOVIE_ID", with: "\(movieId)")
        components.path = newPath

        return components.url
    }

    private func getDefaultURL(fromMovie urlType: URLMoviesType) -> URL? {
        guard let urlBundle = bundle.object(forInfoDictionaryKey: urlMovies) as? [String: String] else {
            return nil
        }

        for (key, value) in urlBundle where key == urlType.stringName {
            return URL(string: value)
        }
        return nil
    }
}
