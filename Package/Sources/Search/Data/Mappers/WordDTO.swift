//
//  WordDTO.swift
//  
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct WordDTO: Decodable {
    let word: String
    let phonetic: String
    let meanings: [MeaningDTO]
    
    func toDomain() -> Word {
        return Word(id: UUID(), word: word, phonetic: phonetic, meanings: meanings.map { $0.toDomain() })
    }
}
