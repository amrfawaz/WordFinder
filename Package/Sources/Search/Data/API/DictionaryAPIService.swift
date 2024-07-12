//
//  DictionaryAPIService.swift
//
//
//  Created by AmrFawaz on 10/07/2024.
//

import Foundation
import Combine
import EnvironmentVariables

public class DictionaryAPIService {
    private let baseURL = EnvironmentVariables.searchUrls.rawValue
    
    public init() {}
    
    func searchWord(_ term: String) -> AnyPublisher<[WordDTO], ErrorResponse> {
        let url = URL(string: "\(baseURL)/\(term)")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: APIResponseWrapper.self, decoder: JSONDecoder())
            .tryMap { apiResponseWrapper in
                switch apiResponseWrapper.response {
                case .success(let words):
                    guard let firstWord = words.first else {
                        throw URLError(.badServerResponse)
                    }
                    return words
                case .failure(let errorResponse):
                    throw errorResponse
                }
            }
            .mapError { error in
                return error as? ErrorResponse ??
                ErrorResponse(
                    title: "Unknown Error",
                    message: error.localizedDescription,
                    resolution: "Please try again later."
                )
            }
            .eraseToAnyPublisher()
    }
}
