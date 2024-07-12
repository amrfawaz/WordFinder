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
