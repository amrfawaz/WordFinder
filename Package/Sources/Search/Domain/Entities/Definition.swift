//
//  Definition.swift
//  
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct Definition: Identifiable, Hashable, Codable {
    let id: UUID
    let definition: String
    let example: String?
}

#if DEBUG
extension Definition {
    static let mockDefinition = Definition(
        id: UUID(),
        definition: "A cold-blooded vertebrate animal that lives in water,moving with the help of fins and breathing with gills.",
        example: "Salmon is a fish."
    )
}
#endif
