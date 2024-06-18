//
//  MovieAPI_SwiftDataTests.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 20/05/24.
//

import XCTest
@testable import Common

final class URLProviderTests: XCTestCase {
    private var sut: DefaultURLProvider!
    private var bundle: BundleMock!
    private var key: URLMoviesType!

    override func setUpWithError() throws {
        bundle = BundleMock()
        bundle.dictToReturn = ["test": "test"]
        key = .detail(1)
        sut = DefaultURLProvider(movieHeader: "movieHedear",
                                 urlMovies: "urlMovies",
                                 bundle: bundle)
    }

    override func tearDown() {
        bundle = nil
        key = nil
        sut = nil
    }

    func testGetNetworkHeaders_whenBundleIsNil_shouldReturnEmptyDictionary() {
        bundle.shouldReturnNil = true

        let result = sut.getNetworkHeaders()
        XCTAssertTrue(result.isEmpty)
    }

    func testGetNetworkHeaders_whenFailCast_shouldReturnEmptyDictionary() {
        bundle.shouldReturnString = true

        let result = sut.getNetworkHeaders()
        XCTAssertTrue(result.isEmpty)
    }

    func testGetNetworkHeaders_whenSuccessDictionary_shouldReturnDictionary() {
        let result = sut.getNetworkHeaders()
        XCTAssertEqual(result, ["test": "test"])
    }

    func testGetURLMovie_whenWrongKeyFromBundle_shouldReturNil() {
        let result = sut.getURLMovie(from: .detail(1))
        XCTAssertNil(result)
    }

    func testGetURLMovie_whenFailCastL_shouldReturNil() {
        bundle.shouldReturnString = true

        let result = sut.getURLMovie(from: .detail(1))
        XCTAssertNil(result)
    }

    func testGetURLMovie_whenDetailSuccess_shouldReturURL() {
        bundle.dictToReturn = [key.stringName: "testMOVIE_ID"]

        let result = sut.getURLMovie(from: key)
        XCTAssertEqual(result?.absoluteString, "test1")
    }

    func testGetURLMovie_whenImageSuccess_shouldReturURL() {
        key = .image("test")
        bundle.dictToReturn = [key.stringName: "test"]

        let result = sut.getURLMovie(from: key)
        XCTAssertEqual(result?.absoluteString, "test/test")
    }

    func testGetURLMovie_whenListSuccess_shouldReturnURL() {
        key = .list(.popular)
        bundle.dictToReturn = [key.stringName: "test"]

        let result = sut.getURLMovie(from: key)
        XCTAssertEqual(result?.absoluteString, "test")
    }
}
