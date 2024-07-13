//
//  Meaning.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

public struct Meaning: Identifiable, Hashable, Codable {
    public let id: UUID
    let partOfSpeech: String
    let definitions: [Definition]
}

#if DEBUG
extension Meaning {
    static let mockMeaning = Meaning(
        id: UUID(),
        partOfSpeech: "noun",
        definitions: [
            Definition.mockDefinition
        ]
    )
}
#endif
