//
//  SearchViewModel.swift
//
//
//  Created by AmrFawaz on 09/07/2024.
//

import Foundation
import Combine

public final class SearchViewModel: ObservableObject {
    @Published var result: [Word]?
    @Published var error: String?
    @Published var history: [Word]?

    private let searchUseCase: SearchUseCase
    private var cancellables = Set<AnyCancellable>()

    public init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }

    var word: String {
        result?.first?.word ?? ""
    }

    func search(term: String) {
        resetSearch()
        searchUseCase.execute(term: term)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error.title
                }
            }, receiveValue: { result in
                self.result = result
                self.cachedWords()
            })
            .store(in: &cancellables)
    }

    func cachedWords() {
        history = searchUseCase.fetchChach()
    }

    func firstPartOfSpeech(of word: Word) -> String {
        return word.meanings.first?.partOfSpeech ?? ""
    }

    private func resetSearch() {
        result = nil
        error = nil
    }
}

// MARK: - Mocks

#if DEBUG
extension SearchViewModel {
    static var mock: SearchViewModel {
        let repository = DictionaryRepositoryImpl(
            apiService: DictionaryAPIService(),
            realmService: RealmService()
        )
        let searchUseCase = SearchUseCase(repository: repository)
        return SearchViewModel(searchUseCase: searchUseCase)
    }
}
#endif
