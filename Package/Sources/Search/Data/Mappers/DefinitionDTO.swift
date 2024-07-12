//
//  DefinitionDTO.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct DefinitionDTO: Decodable {
    let definition: String
    let example: String?
    
    func toDomain() -> Definition {
        return Definition(id: UUID(), definition: definition, example: example)
    }
}
