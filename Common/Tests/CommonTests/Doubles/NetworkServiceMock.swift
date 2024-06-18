//
//  NetworkServiceMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Foundation
@testable import Common

final class NetworkServiceMock: NetworkRequesting {
    var dataToReturn: Encodable = "test"
    var shouldThrowsError = false

    init(headers: [String: String] = ["": ""], urlSession: URLSession = URLSession.shared) { }

    func request(url: URL, httpMethod: HTTPMethod) async throws -> Data {
        if shouldThrowsError {
            throw NSError()
        }
        return try JSONEncoder().encode(dataToReturn)
    }
}
