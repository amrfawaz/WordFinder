//
//  RealmService.swift
//  
//
//  Created by AmrFawaz on 12/07/2024.
//

import Foundation
import RealmManager

public class RealmService {
    public init() {}

    public func fetchCachedWords() -> [Word] {
        let loadedRealmWords: [RealmWord] = RealmManager.shared.load(RealmWord.self)
        let loadedWords = loadedRealmWords.map { Word(realmWord: $0) }
        return loadedWords
    }

    func cacheWord(word: Word) {
        RealmManager.shared.save([RealmWord(word: word)])
    }
}
