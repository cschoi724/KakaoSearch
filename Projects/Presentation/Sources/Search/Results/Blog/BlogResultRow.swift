//
//  BlogResultRow.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import Domain

struct BlogResultRow: View {
    let item: BlogItem

    private let thumbnailSize: CGFloat = 84

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CommonImage(
                source: .remote(item.thumbnail ?? ""),
                mode: .fill,
                width: 96,
                height: 96,
                cornerRadius: 8,
                background: Color(.secondarySystemFill)
            )
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if !item.contents.isEmpty {
                    Text(item.contents)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                HStack(spacing: 4) {
                    if !item.blogName.isEmpty {
                        Text(item.blogName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    Text("·")
                        .foregroundColor(.secondary)
                    if let rawDate = item.datetime {
                        Text(rawDate.kakaoDateTime())
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: thumbnailSize)
    }
}
