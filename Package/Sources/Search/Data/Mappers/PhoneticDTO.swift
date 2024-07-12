//
//  PhoneticDTO.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct PhoneticDTO: Decodable {
    let text: String
    let audio: String
    
    func toDomain() -> Phonetic {
        return Phonetic(id: UUID(), text: text)
    }
}
