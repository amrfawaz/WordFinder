//
//  MeaningsListView.swift
//
//
//  Created by AmrFawaz on 11/07/2024.
//

import CoreInterface
import SwiftUI

struct MeaningsListView: View {
    @ObservedObject private var viewModel: MeaningsListViewModel
    @Binding var path: NavigationPath

    init(
        viewModel: MeaningsListViewModel,
        path: Binding<NavigationPath>
    ) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        VStack {
            ScrollView {
                meaningsList
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationTitle(viewModel.word + " Meanings")
        .navigationBarTitleDisplayMode(.large)
    }

    private func handleMeaningItemAction(
        _ action: MeaningsListViewModel.MeaningItemAction,
        definitions: [Definition]
    ) {
        switch action {
        case .didTapMeaningItem:
            path.append(definitions)
        }
    }
}

// MARK: - Extension

private extension MeaningsListView {
    private var meaningsList: some View {
        ForEach(viewModel.meanings) { meaning in
            meaningCell(meaning)
        }
    }

    var disclosureIcon: some View {
        VStack {
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }

    private func meaningCell(_ meaning: Meaning) -> some View {
        VStack {
            HStack {
                content(meaning)

                Spacer()

                if !meaning.definitions.isEmpty {
                    disclosureIcon
                }
            }

            Divider()
        }
        .onReceive(viewModel.subject) { action in
            handleMeaningItemAction(
                .didTapMeaningItem,
                definitions: meaning.definitions
            )
        }
        .onTapGesture {
            viewModel.subject.send(.didTapMeaningItem)
        }
        .navigationDestination(for: [Definition].self) { definitions in
            let definitionsListViewModel = DefinitionsListViewModel(
                word: viewModel.word,
                definitions: definitions
            )
            DefinitionsListView(viewModel: definitionsListViewModel, path: $path)
        }
    }

    private func content(_ meaning: Meaning) -> some View {
        VStack(alignment: .leading) {
            HStack {
                word
                partOfSpeech(meaning.partOfSpeech)

                Spacer()
            }

            if !meaning.definitions.isEmpty {
                Text(viewModel.firstDefinition(of: meaning))
                    .typography(.callout)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.vertical, Style.Spacing.sm)
    }

    private var word: some View {
        HStack {
            Text(viewModel.word)
                .typography(.caption02)
        }
    }

    private func partOfSpeech(_ partOfSpeech: String) -> some View {
        Text(partOfSpeech)
            .typography(.callout)
            .foregroundStyle(.gray)
    }
}

// MARK: - Preview

struct MeaningsListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()

        VStack {
            MeaningsListView(
                viewModel: MeaningsListViewModel(
                    word: "fish",
                    meanings: [.mockMeaning, .mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning,.mockMeaning]),
                path: $path
            )
            Spacer()
        }
    }
}
