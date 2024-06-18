//
//  URLProviderMock.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import Foundation
@testable import Common

final class URLProviderMock: URLProvider {
    var shouldReturnNil = false

    func getURLMovie(from urlType: URLMoviesType) -> URL? {
        if shouldReturnNil {
            return nil
        }
        return URL(string: "testURL")
    }

    func getNetworkHeaders() -> [String: String] {
        ["test": "test"]
    }
}
