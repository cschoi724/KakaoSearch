//
//  ImageResultsView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct ImageResultsView: View {
    let store: StoreOf<ImageResultsFeature>

    private let horizontalPadding: CGFloat = 16
    private let interItemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geo in
                let totalWidth = geo.size.width
                let cellWidth = (totalWidth - (horizontalPadding * 2) - interItemSpacing) / 2
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(
                                .flexible(minimum: 0, maximum: .infinity),
                                spacing: interItemSpacing
                            ),
                            GridItem(
                                .flexible(minimum: 0, maximum: .infinity),
                                spacing: interItemSpacing
                            )
                        ],
                        alignment: .leading,
                        spacing: lineSpacing
                    ) {
                        ForEach(
                            Array(viewStore.items.enumerated()),
                            id:  \.offset,
                            content: { index, item in
                                ImageCardView(item: item, width: cellWidth)
                                    .onAppear {
                                        if index >= viewStore.items.count - 4 {
                                            viewStore.send(.loadNextPage)
                                        }
                                    }
                                    .onTapGesture {
                                        viewStore.send(.didSelect(item))
                                    }
                            }
                        )
                    }
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
    }
}
