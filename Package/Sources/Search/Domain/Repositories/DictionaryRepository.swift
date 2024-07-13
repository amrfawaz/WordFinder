//
//  DictionaryRepository.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation
import Combine

public protocol DictionaryRepository {
    func searchWord(_ term: String) -> AnyPublisher<[Word], ErrorResponse>
    func fetchCachedWords() -> [Word]
}

// Mock Repository
public class MockDictionaryRepository: DictionaryRepository {
    var mockWords: [Word] = []
    var shouldFail: Bool = false
    var mockError: ErrorResponse?

    public func searchWord(_ term: String) -> AnyPublisher<[Word], ErrorResponse> {
        if shouldFail {
            return Fail(error: mockError ?? ErrorResponse(title: "Error", message: "Test error", resolution: "Test resolution"))
                .eraseToAnyPublisher()
        } else {
            return Just(mockWords)
                .setFailureType(to: ErrorResponse.self)
                .eraseToAnyPublisher()
        }
    }

    public func fetchCachedWords() -> [Word] {
        return mockWords
    }
}
