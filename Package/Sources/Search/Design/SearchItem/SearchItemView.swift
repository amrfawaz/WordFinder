//
//  SearchItemView.swift
//
//
//  Created by AmrFawaz on 09/07/2024.
//

import CoreInterface
import SwiftUI

struct SearchItemView: View {
    @ObservedObject private var viewModel: SearchItemViewModel

    init(viewModel: SearchItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    word
                    if !viewModel.partOfSpeech.isEmpty {
                        definition
                    }
                }

                Spacer()

                disclosureIcon
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.subject.send(.didTapSearchItem())
        }
    }

    private var word: some View {
        HStack {
            Text(viewModel.word)
                .typography(.caption02)
            Text(viewModel.phonetic)
                .typography(.caption01)
                .foregroundStyle(.gray)
            Spacer()
        }
    }

    private var definition: some View {
        HStack {
            Text(viewModel.partOfSpeech)
                .typography(.caption01)
            Spacer()
        }
    }

    private var disclosureIcon: some View {
        HStack {
            Spacer()

            VStack {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - Preview

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchItemView(viewModel: .mock)
            SearchItemView(viewModel: .mock)
            Spacer()
        }
    }
}
