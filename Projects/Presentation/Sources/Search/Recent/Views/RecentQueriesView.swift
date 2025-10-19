//
//  RecentQueriesView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//


import SwiftUI
import ComposableArchitecture

public struct RecentQueriesView: View {
    let store: StoreOf<RecentQueriesFeature>
    let isEditing: Bool

    public init(store: StoreOf<RecentQueriesFeature>, isEditing: Bool) {
        self.store = store
        self.isEditing = isEditing
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 12) {
                if isEditing {
                    RecentQueriesFilteredView(store: store)
                } else {
                    RecentQueriesAllView(store: store)
                }
            }
            .onAppear {
                viewStore.send(.loadRequested)
            }
        }
    }
}
