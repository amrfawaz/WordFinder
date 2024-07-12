//
//  DictionaryRepositoryImpl.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation
import Combine

public class DictionaryRepositoryImpl: DictionaryRepository {
    private let apiService: DictionaryAPIService
    private let realmService: RealmService
    
    public init(apiService: DictionaryAPIService, realmService: RealmService) {
        self.apiService = apiService
        self.realmService = realmService
    }
    
    public func searchWord(_ term: String) -> AnyPublisher<[Word], ErrorResponse> {
        return apiService.searchWord(term)
            .map { $0.map { $0.toDomain()} }
            .handleEvents(receiveOutput: { word in
                if let fisrtWord = word.first {
                    self.realmService.cacheWord(word: fisrtWord)
                }
            })
            .eraseToAnyPublisher()
    }

    public func fetchCachedWords() -> [Word] {
        return realmService.fetchCachedWords()
    }
}
