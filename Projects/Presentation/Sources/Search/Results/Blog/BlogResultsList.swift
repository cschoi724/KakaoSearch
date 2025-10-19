//
//  BlogResultsList.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import Domain

struct BlogResultsList: View {
    let items: [BlogItem]
    let onSelect: (Int) -> Void
    let onLoadNext: () -> Void

    var body: some View {
        List {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Button {
                    onSelect(index)
                } label: {
                    BlogResultRow(item: item)
                }
                .buttonStyle(.plain)
                .listRowInsets(
                    EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                )
                .listRowSeparator(.hidden, edges: .all)
                .onAppear {
                    if index >= items.count - 3 {
                        onLoadNext()
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.automatic)
    }
}
