//
//  MeaningsListViewModel.swift
//  
//
//  Created by AmrFawaz on 11/07/2024.
//

import Foundation
import Combine

public final class MeaningsListViewModel: ObservableObject {
    public enum MeaningItemAction {
        case didTapMeaningItem
    }

    let word: String
    let meanings: [Meaning]
    let subject = PassthroughSubject<MeaningItemAction, Never>()

    init(
        word: String,
        meanings: [Meaning]
    ) {
        self.word = word
        self.meanings = meanings
    }

    func firstDefinition(of meaning: Meaning) -> String{
        meaning.definitions.first?.definition ?? ""
    }
}

// MARK: - Mocks

#if DEBUG
extension MeaningsListViewModel {
    static var mock: MeaningsListViewModel {
        return MeaningsListViewModel(
            word: "Fish",
            meanings: [
                Meaning.mockMeaning,
                Meaning.mockMeaning,
                Meaning.mockMeaning
            ]
        )
    }
}
#endif
