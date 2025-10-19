//
//  SearchContentContainer.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SearchContentContainer: View {
    var query: String
    var isEditing: Bool
    var submittedQuery: String?
    let recentQueriesStore: StoreOf<RecentQueriesFeature>
    let resultsStore: StoreOf<SearchResultsFeature>
    
    var body: some View {
        Group {
            if submittedQuery == nil {
                RecentQueriesView(
                    store: recentQueriesStore,
                    isEditing: isEditing
                )
            } else {
                SearchResultsView(
                    store: resultsStore
                )
            }
        }
        .animation(.easeInOut, value: query)
    }
}
