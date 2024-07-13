//
//  URLSessionProtocol.swift
//
//
//  Created by AmrFawaz on 13/07/2024.
//

import Foundation
import Combine

public protocol URLSessionProtocol {
    func dataTask(for url: URL) -> AnyPublisher<
        (
            data: Data,
            response: URLResponse
        ),
        URLError
    >
}

extension URLSession: URLSessionProtocol {
    public func dataTask(for url: URL) -> AnyPublisher<
        (
            data: Data,
            response: URLResponse
        ),
        URLError
    > {
        return self.dataTaskPublisher(for: url)
            .mapError { $0 as URLError }
            .eraseToAnyPublisher()
    }
}

// MARK: - Mocks

#if DEBUG
public class MockURLSession: URLSessionProtocol {
    let data: Data?
    let response: URLResponse?
    let error: URLError?

    init(
        data: Data?,
        response: URLResponse?,
        error: URLError?
    ) {
        self.data = data
        self.response = response
        self.error = error
    }

    public func dataTask(for url: URL) -> AnyPublisher<
        (
            data: Data,
            response: URLResponse
        ),
        URLError
    > {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            let data = self.data ?? Data()
            let response = self.response ?? URLResponse()
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }
}
#endif
