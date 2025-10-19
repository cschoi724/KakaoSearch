//
//  VideoResultsView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

public struct VideoResultsView: View {
    let store: StoreOf<VideoResultsFeature>

    public init(store: StoreOf<VideoResultsFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Group {
                if viewStore.items.isEmpty {
                    VideoEmptyView(query: viewStore.query, isLoading: viewStore.isLoading)
                } else {
                    VideoResultsList(
                        items: viewStore.items,
                        isLoading: viewStore.isLoading,
                        isEnd: viewStore.isEnd,
                        loadNextPage: { viewStore.send(.loadNextPage) },
                        didSelect: { item in
                            if let url = URL(string: item.url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    )
                }
            }
            .animation(.default, value: viewStore.items)
            .refreshable { viewStore.send(.refresh) }
        }
    }
}
