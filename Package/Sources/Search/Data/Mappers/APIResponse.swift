//
//  APIResponse.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation

enum APIResponse {
    case success([WordDTO])
    case failure(ErrorResponse)
}

public struct ErrorResponse: Codable, Error {
    let title: String
    let message: String
    let resolution: String
}
