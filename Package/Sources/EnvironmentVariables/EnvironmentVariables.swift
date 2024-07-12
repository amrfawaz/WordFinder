//
//  EnvironmentVariables.swift
//
//
//  Created by AmrFawaz on 09/07/2024.
//

import Foundation

public enum EnvironmentVariables: String {
    case baseUrl = "https://api.dictionaryapi.dev/api"
    case version = "/v2"
    case searchEndPoint = "/entries"
    case language = "/en"
    case accept = "application/json"
    case searchUrls = "https://api.dictionaryapi.dev/api/v2/entries/en"

    public var searchUrl: String {
        EnvironmentVariables.baseUrl.rawValue +
        EnvironmentVariables.version.rawValue +
        EnvironmentVariables.searchEndPoint.rawValue +
        EnvironmentVariables.language.rawValue
    }
}
