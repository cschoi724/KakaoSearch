//
//  RecentQueriesFilteredView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RecentQueriesFilteredView: View {
    let store: StoreOf<RecentQueriesFeature>

    var body: some View {
        WithViewStore(store, observe: { $0.filtered }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewStore.state, id: \.self) { query in
                        RecentQueryRow(
                            title: query,
                            filtered: true,
                            onTap: { viewStore.send(.didSelect(query)) },
                            onDelete: { viewStore.send(.deleteRequested(query)) }
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
