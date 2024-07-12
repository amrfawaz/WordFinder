//
//  SearchItemViewModel.swift
//
//
//  Created by AmrFawaz on 09/07/2024.
//

import Foundation
import Combine

public final class SearchItemViewModel: ObservableObject {
    public enum SearchItemAction {
        case didTapSearchItem(meaning: [Meaning] = [])
        case didTapHistoryItem(word: String)
    }

    let word: String
    let phonetic: String
    let partOfSpeech: String
    let subject = PassthroughSubject<SearchItemAction, Never>()

    init(
        word: String,
        phonetic: String,
        partOfSpeech: String
    ) {
        self.word = word
        self.phonetic = phonetic
        self.partOfSpeech = partOfSpeech
    }
}

// MARK: - Mocks

#if DEBUG
extension SearchItemViewModel {
    static var mock: SearchItemViewModel {
        return SearchItemViewModel(
            word: "Fish",
            phonetic: "/fɪʃ/",
            partOfSpeech: "noun"
        )
    }
}
#endif
