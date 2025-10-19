//
//  SearchResultsView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct SearchResultsView: View {
    let store: StoreOf<SearchResultsFeature>

    public init(store: StoreOf<SearchResultsFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 12) {
                SearchResultsTabs(
                    selected: viewStore.selectedTab,
                    onSelect: { viewStore.send(.selectTab($0)) }
                )
                .padding(.horizontal, 16)

                SearchResultsContent(
                    store: store,
                    selected: viewStore.selectedTab
                )
                .animation(.easeInOut, value: viewStore.selectedTab)
            }
            .padding(.top, 4)
        }
    }
}
