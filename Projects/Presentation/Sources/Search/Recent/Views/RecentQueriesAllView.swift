//
//  RecentQueriesAllView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RecentQueriesAllView: View {
    let store: StoreOf<RecentQueriesFeature>

    var body: some View {
        WithViewStore(store, observe: { $0.all }) { viewStore in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .center) {
                        Text("최근 검색어")
                            .font(.headline)
                        Spacer()
                        Button("전체 삭제") {
                            viewStore.send(.deleteRequested(""))
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 20)

                    if viewStore.state.isEmpty {
                        Text("최근 검색어가 없습니다.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
                    } else {
                        ForEach(viewStore.state, id: \.self) { query in
                            RecentQueryRow(
                                title: query,
                                filtered: false,
                                onTap: { viewStore.send(.didSelect(query)) },
                                onDelete: { viewStore.send(.deleteRequested(query)) }
                            )
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
