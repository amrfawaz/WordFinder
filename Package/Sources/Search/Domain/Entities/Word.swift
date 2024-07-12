//
//  Word.swift
//  
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

public struct Word: Identifiable, Hashable, Codable {
    public let id: UUID
    let word: String
    let phonetic: String
    let meanings: [Meaning]
}

// MARK: - Stubs

#if DEBUG
extension Word {
    static let word = Word(
        id: UUID(),
        word: "Fish",
        phonetic: "/fɪʃ/",
        meanings: [
            .mockMeaning
        ]
    )
}
#endif
