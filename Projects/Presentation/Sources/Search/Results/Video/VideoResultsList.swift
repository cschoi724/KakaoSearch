//
//  VideoResultsList.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct VideoResultsList: View {
    let items: [VideoItem]
    let isLoading: Bool
    let isEnd: Bool
    let loadNextPage: () -> Void
    let didSelect: (VideoItem) -> Void
    
    var body: some View {
        List {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                VideoRowView(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        didSelect(item)
                    }
                    .onAppear {
                        if index >= items.count - 3,
                           !isLoading,
                           !isEnd {
                            loadNextPage()
                        }
                    }

                    .listRowSeparator(.hidden)
            }

            if isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding(.vertical, 16)
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
}
