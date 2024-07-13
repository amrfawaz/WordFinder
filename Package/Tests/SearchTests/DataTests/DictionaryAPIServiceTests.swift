//
//  DictionaryAPIServiceTests.swift
//  
//
//  Created by AmrFawaz on 13/07/2024.
//

import XCTest
import Combine

@testable import Search

final class DictionaryAPIServiceTests: XCTestCase {
    var apiService: DictionaryAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        apiService = nil
        cancellables = nil
        super.tearDown()
    }

    func testSearchWordSuccess() {
        // Given
        let term = "test"
        let mockResponseJSON = """
        [
            {
                "word": "test",
                "phonetic": "test",
                "meanings": []
            }
        ]
        """.data(using: .utf8)!
        
        let mockURLSession = MockURLSession(data: mockResponseJSON, response: nil, error: nil)
        apiService = DictionaryAPIService(urlSession: mockURLSession)

        // When
        let expectation = XCTestExpectation(description: "Search word success")
        apiService.searchWord(term)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but received failure")
                }
            }, receiveValue: { words in
                // Then
                XCTAssertEqual(words.count, 1, "Number of words received should be one")
                XCTAssertEqual(words.first?.word, "test", "The word received should be test")
                XCTAssertEqual(words.first?.phonetic, "test", "The phonetic word recieved should be test")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }


    func testSearchWordFailure() {
        // Given
        let term = "test"
        let mockErrorResponseJSON = """
        {
            "title": "Error",
            "message": "Test error",
            "resolution": "Test resolution"
        }
        """.data(using: .utf8)!
        
        let mockURLSession = MockURLSession(data: mockErrorResponseJSON, response: nil, error: nil)
        apiService = DictionaryAPIService(urlSession: mockURLSession)

        // When
        let expectation = XCTestExpectation(description: "Search word failure")
        apiService.searchWord(term)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Then
                    XCTAssertEqual(error.title, "Error", "Error title shoould be Error")
                    XCTAssertEqual(error.message, "Test error", "Error message shoould be Test error")
                    XCTAssertEqual(error.resolution, "Test resolution", "Error resolution shoould be Test resolution")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but received success")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
