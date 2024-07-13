//
//  SearchUseCaseTests.swift
//  
//
//  Created by AmrFawaz on 13/07/2024.
//

import XCTest
import Combine
@testable import Search

final class SearchUseCaseTests: XCTestCase {

    var searchUseCase: SearchUseCase!
    var mockRepository: MockDictionaryRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockDictionaryRepository()
        searchUseCase = SearchUseCase(repository: mockRepository)
        cancellables = []
    }

    override func tearDown() {
        searchUseCase = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecuteSuccess() {
        // Given
        let term = "test"
        let expectedWords = [Word(id: UUID(), word: "test", phonetic: "test", meanings: [])]
        mockRepository.mockWords = expectedWords
        mockRepository.shouldFail = false

        // When
        let expectation = XCTestExpectation(description: "Execute success")
        searchUseCase.execute(term: term)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but received failure")
                }
            }, receiveValue: { words in
                // Then
                XCTAssertEqual(words.count, 1, "The number of words recieved should be one")
                XCTAssertEqual(words, expectedWords, "Word recived should be correct")
                XCTAssertEqual(words.first?.word, "test", "The word received should be test")
                XCTAssertEqual(words.first?.phonetic, "test", "The phonetic word recieved should be test")

                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testExecuteFailure() {
        // Given
        let term = "test"
        let expectedError = ErrorResponse(title: "Error", message: "Test error", resolution: "Test resolution")
        mockRepository.shouldFail = true
        mockRepository.mockError = expectedError

        // When
        let expectation = XCTestExpectation(description: "Execute failure")
        searchUseCase.execute(term: term)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Then
                    XCTAssertEqual(error.title, expectedError.title, "Error title shoould be Error")
                    XCTAssertEqual(error.message, expectedError.message, "Error message shoould be Test error")
                    XCTAssertEqual(error.resolution, expectedError.resolution, "Error resolution shoould be Test resolution")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but received success")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
