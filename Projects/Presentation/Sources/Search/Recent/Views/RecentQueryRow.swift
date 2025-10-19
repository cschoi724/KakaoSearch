//
//  RecentQueryRow.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

public struct RecentQueryRow: View {
    let title: String
    let filtered: Bool
    let onTap: () -> Void
    let onDelete: () -> Void

    public init(
        title: String,
        filtered: Bool,
        onTap: @escaping () -> Void,
        onDelete: @escaping () -> Void
    ) {
        self.title = title
        self.filtered = filtered
        self.onTap = onTap
        self.onDelete = onDelete
    }

    public var body: some View {
        HStack(spacing: 12) {
            Text(title)
                .font(.body)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            if filtered {
                Image("icn_search_up", bundle: .presentation)
                    .renderingMode(.original)
                    .frame(width: 20, height: 20)
            } else {
                Button {
                    onDelete()
                } label: {
                    Image("icn_search_delete", bundle: .presentation)
                        .renderingMode(.original)
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.plain)
            }
            
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .listRowSeparator(.hidden)
    }
}
