//
//  BlogResultsView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct BlogResultsView: View {
    let store: StoreOf<BlogResultsFeature>
    @Environment(\.openURL) private var openURL
    
    public init(store: StoreOf<BlogResultsFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 12) {
                BlogResultsContent(
                    items: viewStore.items,
                    isLoading: viewStore.isLoading,
                    onRefresh: {
                        viewStore.send(.refresh)
                    },
                    onSelect: { item in
                        if let url = URL(string: item.url) {
                            openURL(url)
                        }
                    },
                    onLoadNext: {
                        viewStore.send(.loadNextPage)
                    }
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}
