//
//  NetworkUseCase.swift
//  MovieAPI&SwiftData
//
//  Created by Matheus Vicente on 20/05/24.
//

import Foundation
import NetworkService

public protocol NetworkRequestUseCase {
    func request<T: Decodable>(urlMovie: URLMoviesType) async -> T?
}

final public class NetworkUseCase: NetworkRequestUseCase {
    let urlProvider: URLProvider
    let networkService: NetworkRequesting

    public init(urlProvider: URLProvider = DefaultURLProvider(),
                networkService: NetworkRequesting = NetworkService(headers: DefaultURLProvider().getNetworkHeaders())) {
        self.urlProvider = urlProvider
        self.networkService = networkService
    }
    
    public func request<T: Decodable>(urlMovie: URLMoviesType) async -> T? {
        do {
            guard let url = urlProvider.getURLMovie(from: urlMovie) else {
                return nil
            }
            let data = try await self.networkService.request(url: url, httpMethod: .get)
            if T.self == Data.self {
                return data as? T
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
