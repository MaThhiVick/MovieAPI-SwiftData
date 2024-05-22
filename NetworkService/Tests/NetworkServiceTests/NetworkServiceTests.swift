import XCTest
@testable import NetworkService

class NetworkServiceTests: XCTestCase {
    var networkService: NetworkService!
    var urlProtocol: MockURLProtocol!
    let header: [String: String] = ["Content-Type": "application/json"]
    let url = URL(string: "https://example.com")!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        networkService = NetworkService(headers: header, urlSession: urlSession)
        urlProtocol = MockURLProtocol()
    }

    override func tearDown() {
        networkService = nil
    }

    func testRequest_successfulRequest_shouldReturnData() async throws {
        let data = try JSONEncoder().encode("some encoded data")
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        let result = try await networkService.request(url: url, httpMethod: .get)

        XCTAssertEqual(result, data)
    }

    func testRequest_failRequest_shouldReturnError() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        do {
            let _ = try await networkService.request(url: url, httpMethod: .get)
        } catch {
            XCTAssertEqual(error as! NetworkError, NetworkError.errorRequest)
        }
    }
}

