//
//  NetworkManager.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

public enum NetworkError: Error {
    case invalidRequest
    case invalidURL
    case noData
    case decodingError
    case serverError

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            "Invalid Request"
        case .invalidURL:
            "Invalid URL"
        case .noData:
            "No data received"
        case .decodingError:
            "Failed to decode data"
        case .serverError:
            "Server Error"
        }
    }
}

public enum HTTPMethod: String {
    case get = "GET"
}

public class NetworkManager {
    public init() {}

    public func request<T: Decodable>(request: URLRequest, of type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

// MARK: - Mocks
#if DEBUG
class MockNetworkManager: NetworkManager {
    var responseData: Data?
    var responseError: NetworkError?

    override func request<T: Decodable>(request: URLRequest, of type: T.Type) async throws -> T {
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw NetworkError.noData
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}
#endif
