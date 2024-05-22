//
//  NetworkUseCaseTests.swift
//  MovieAPI&SwiftDataTests
//
//  Created by Matheus Vicente on 22/05/24.
//

import XCTest
@testable import MovieAPI_SwiftData

final class NetworkUseCaseTests: XCTestCase {
   private var sut: NetworkUseCase!
   private var urlProvider: URLProviderMock!
   private var networkService: NetworkServiceMock!

    override func setUpWithError() throws {
        urlProvider = URLProviderMock()
        networkService = NetworkServiceMock()
        sut = NetworkUseCase(urlProvider: urlProvider, networkService: networkService)
    }

    override func tearDownWithError() throws {
        urlProvider = nil
        networkService = nil
        sut = nil
    }

    func testRequest_whenURLisNil_shouldReturnNil() async {
        urlProvider.shouldReturnNil = true

        if let _: String = await sut.request(urlMovie: .detail(0)) {
            XCTFail("should return nil")
            return
        }
    }

    func testRequest_networkRequestThrowError_shouldReturnNil() async {
        networkService.shouldThrowsError = true

        if let _: String = await sut.request(urlMovie: .detail(0)) {
            XCTFail("should return nil")
            return
        }
    }

    func testRequest_askForDataType_shouldReturnData() async {
        guard let data: Data = await sut.request(urlMovie: .detail(0)) else {
            XCTFail("should return some data")
            return
        }

        let decode = try! JSONDecoder().decode(String.self, from: data)
        XCTAssertEqual(decode, "test")
    }

    func testRequest_askForStringType_shouldReturnString() async {
        guard let data: String = await sut.request(urlMovie: .detail(0)) else {
            XCTFail("should return string")
            return
        }

        XCTAssertEqual(data, "test")
    }
}
