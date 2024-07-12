//
//  MeaningDTO.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct MeaningDTO: Decodable {
    let partOfSpeech: String
    let definitions: [DefinitionDTO]
    
    func toDomain() -> Meaning {
        return Meaning(id: UUID(), partOfSpeech: partOfSpeech, definitions: definitions.map { $0.toDomain() })
    }
}
