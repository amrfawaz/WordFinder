//
//  WordFinderApp.swift
//  WordFinder
//
//  Created by AmrFawaz on 09/07/2024.
//

import SwiftUI
import Search

@main
struct WordFinderApp: App {
    var body: some Scene {
        WindowGroup {
            let apiService = DictionaryAPIService()
            let realmService = RealmService()
            let repository = DictionaryRepositoryImpl(apiService: apiService, realmService: realmService)
            let searchUseCase = SearchUseCase(repository: repository)
            let viewModel = SearchViewModel(searchUseCase: searchUseCase)
            
            SearchView(viewModel: viewModel)
        }
    }
}
