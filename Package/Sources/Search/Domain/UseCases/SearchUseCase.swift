//
//  SearchUseCase.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

import Foundation
import Combine

public class SearchUseCase {
    private let repository: DictionaryRepository
    
    public init(repository: DictionaryRepository) {
        self.repository = repository
    }
    
    func execute(term: String) -> AnyPublisher<[Word], ErrorResponse> {
        return repository.searchWord(term)
    }

    func fetchChach() -> [Word] {
        return repository.fetchCachedWords()
    }
}
