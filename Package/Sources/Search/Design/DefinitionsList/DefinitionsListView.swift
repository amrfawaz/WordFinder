//
//  DefinitionsListView.swift
//
//
//  Created by AmrFawaz on 11/07/2024.
//

import CoreInterface
import SwiftUI

struct DefinitionsListView: View {
    @ObservedObject private var viewModel: DefinitionsListViewModel
    @Binding var path: NavigationPath

    init(
        viewModel: DefinitionsListViewModel,
        path: Binding<NavigationPath>
    ) {
        self.viewModel = viewModel
        self._path = path
    }

    var body: some View {
        VStack {
            ScrollView {
                definitionsList
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationTitle(viewModel.word + " Definitions")
        .navigationBarTitleDisplayMode(.large)
    }

    private var definitionsList: some View {
            ForEach(viewModel.definitions) { definition in
                VStack {
                    definitionView(definition)
                    exampleView(definition)
                    Divider()
                }
            }
    }

    private func definitionView(_ definition: Definition) -> some View {
        HStack(alignment: .top) {
            Text("Definition: ")
                .typography(.body01)
            Text(definition.definition)
                .typography(.callout)
                .foregroundStyle(.gray)

            Spacer()
        }
    }

    private func exampleView(_ definition: Definition) -> some View {
        HStack(alignment: .top) {
            if let example = definition.example {
                Text("Expample: ")
                    .typography(.body01)

                Text(example)
                    .typography(.callout)
                    .foregroundStyle(.gray)
            }

            Spacer()
        }
    }
}

// MARK: - Preview

struct DefinitionsListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()

        VStack {
            DefinitionsListView(
                viewModel: DefinitionsListViewModel(
                    word: "Fish",
                    definitions: [
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,.mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                        .mockDefinition,
                    ]
                ), path: $path
            )
            Spacer()
        }
    }
}
