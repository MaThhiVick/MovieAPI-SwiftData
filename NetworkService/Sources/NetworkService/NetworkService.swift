import Foundation

public protocol NetworkRequesting {
    init(headers: [String: String], urlSession: URLSession)
    func request(url: URL, httpMethod: HTTPMethod) async throws -> Data
}

public final class NetworkService: NetworkRequesting {
    public let headers: [String: String]
    let urlSession: URLSession

    required public init(headers: [String: String], urlSession: URLSession = URLSession.shared) {
        self.headers = headers
        self.urlSession = urlSession
    }

    public func request(url: URL, httpMethod: HTTPMethod) async throws -> Data {
        let request = setupRequest(url: url, httpMethod: httpMethod)

        do {
            let (data, _) = try await urlSession.data(for: request)
            return data
        } catch {
            throw NetworkError.errorRequest
        }
    }

    private func setupRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

