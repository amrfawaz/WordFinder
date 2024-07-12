//
//  SearchView.swift
//
//
//  Created by AmrFawaz on 09/07/2024.
//

import SwiftUI
import CoreInterface

public struct SearchView: View {
    @StateObject private var viewModel: SearchViewModel
    @State private var searchTerm: String = ""
    @State private var path = NavigationPath()

    public init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        textField
                        resultList
                        Spacer()
                    }
                    .frame(height: geometry.size.height * 0.6)
                    .frame(maxWidth: .infinity)

                    if let history = viewModel.history, !history.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Search History")
                                .typography(.heading02)
                            historyList
                        }
                        .frame(height: geometry.size.height * 0.4)
                        .frame(maxWidth: .infinity)
                    }
                }
                .onFirstAppear {
                    viewModel.cachedWords()
                }
            }
            .padding()
            .navigationTitle("Word Finder")
        }
    }
}

// MARK: - Extension

private extension SearchView {
    private var textField: some View {
        TextField("Search for a word", text: $searchTerm)
            .textFieldStyle(DefaultTextFieldStyle())
            .typography(Style.Font.heading01)
            .onSubmit {
                viewModel.search(term: searchTerm)
            }
    }

    private var resultList: some View {
        ScrollView {
            VStack {
                if let result = viewModel.result {
                    ForEach(result) { word in
                        let searchItemViewModel = SearchItemViewModel(
                            word: word.word,
                            phonetic: word.phonetic,
                            partOfSpeech: viewModel.firstPartOfSpeech(of: word)
                        )

                        SearchItemView(viewModel: searchItemViewModel)
                            .onReceive(searchItemViewModel.subject) { action in
                                handleSearchItemAction(.didTapSearchItem(meaning: word.meanings))
                            }

                        Divider()
                    }
                }
            }
            .navigationDestination(for: [Meaning].self) { meanings in
                let meaningsListViewModel = MeaningsListViewModel(
                    word: viewModel.word,
                    meanings: meanings
                )
                MeaningsListView(viewModel: meaningsListViewModel, path: $path)
            }
        }
    }

    private var historyList: some View {
        ScrollView {
            VStack {
                if let history = viewModel.history {
                    ForEach(history) { word in
                        let searchItemViewModel = SearchItemViewModel(
                            word: word.word,
                            phonetic: "",
                            partOfSpeech: ""
                        )

                        SearchItemView(viewModel: searchItemViewModel)
                            .onReceive(searchItemViewModel.subject) { action in
                                handleSearchItemAction(.didTapHistoryItem(word: word.word))
                            }

                        Divider()
                    }
                }
            }
        }
    }

    private func handleSearchItemAction(
        _ action: SearchItemViewModel.SearchItemAction
    ) {
        switch action {
        case .didTapSearchItem(let meanings):
            path.append(meanings)
        case .didTapHistoryItem(let word):
            viewModel.search(term: word)
        }
    }
}

// MARK: - Preview

struct SerchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel.mock)
    }
}
