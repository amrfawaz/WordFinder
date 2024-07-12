//
//  APIResponseWrapper.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

struct APIResponseWrapper: Decodable {
    let response: APIResponse

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let words = try? container.decode([WordDTO].self) {
            self.response = .success(words)
        } else if let errorResponse = try? container.decode(ErrorResponse.self) {
            self.response = .failure(errorResponse)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Response does not match expected types.")
        }
    }
}
