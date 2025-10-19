//
//  SearchRootView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct SearchRootView: View {
    let store: StoreOf<SearchFeature>

    public init(store: StoreOf<SearchFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                SearchHeader(
                    text: viewStore.binding(
                        get: \.query,
                        send: { .queryChanged($0) }
                    ),
                    onSubmit: { viewStore.send(.submit) },
                    onClear: { viewStore.send(.clearTapped) }
                )
                SearchContentContainer(
                    query: viewStore.query,
                    isEditing: viewStore.isEditing,
                    submittedQuery: viewStore.submittedQuery,
                    recentQueriesStore: store.scope(
                        state: \.recent,
                        action: SearchFeature.Action.recent
                    ),
                    resultsStore: store.scope(
                        state: \.results,
                        action: SearchFeature.Action.results
                    )
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear { viewStore.send(.onAppear) }
            .background(Color(.systemBackground))
        }
    }
    
}

#Preview {
    SearchRootView(
        store: .init(
            initialState: SearchFeature.State(),
            reducer: {
                SearchFeature(
                    env: .init(
                        recentEnv: .init(
                            loadRecentQueries: PreviewLoadRecentQueriesUseCase(),
                            saveRecentQuery: PreviewSaveRecentQueryUseCase()
                        ),
                        resultsEnv: .init(
                            blogEnv: .init(
                                searchBlogs: PreviewSearchBlogsUseCase(),
                            ),
                            imageEnv: .init(
                                searchImages: PreviewSearchImagesUseCase()
                            ),
                            videoEnv: .init(
                                searchVideos: PreviewSearchVideosUseCase()
                            )
                        )
                    )
                )
            }
        )
    )
}
