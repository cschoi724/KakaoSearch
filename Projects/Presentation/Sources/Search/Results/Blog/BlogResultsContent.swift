//
//  BlogResultsContent.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import Domain

struct BlogResultsContent: View {
    let items: [BlogItem]
    let isLoading: Bool
    let onRefresh: () -> Void
    let onSelect: (Int) -> Void
    let onLoadNext: () -> Void

    var body: some View {
        Group {
            if isLoading && items.isEmpty {
                BlogResultsLoadingView()
            } else if items.isEmpty {
                BlogResultsEmptyView(onRefresh: onRefresh)
            } else {
                BlogResultsList(
                    items: items,
                    onSelect: onSelect,
                    onLoadNext: onLoadNext
                )
            }
        }
    }
}
