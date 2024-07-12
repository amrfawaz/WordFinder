//
//  DefinitionsListViewModel.swift
//
//
//  Created by AmrFawaz on 11/07/2024.
//

import Foundation
import Combine

public final class DefinitionsListViewModel: ObservableObject {
    let word: String
    let definitions: [Definition]

    init(
        word: String,
        definitions: [Definition]
    ) {
        self.word = word
        self.definitions = definitions
    }
}

// MARK: - Mocks

#if DEBUG
extension DefinitionsListViewModel {
    static var mock: DefinitionsListViewModel {
        return DefinitionsListViewModel(
            word: "Fish",
            definitions: [
                Definition.mockDefinition,
                Definition.mockDefinition,
                Definition.mockDefinition
            ]
        )
    }
}
#endif
