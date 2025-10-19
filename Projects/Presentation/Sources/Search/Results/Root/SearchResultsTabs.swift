//
//  SearchResultsTabs.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct SearchResultsTabs: View {
    enum Tab: Hashable {
        case blog
        case image
        case video
    }

    let selected: SearchResultsFeature.State.Tab
    let onSelect: (SearchResultsFeature.State.Tab) -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            SegmentedTab(
                title: "블로그",
                isSelected: selected == .blog,
                action: { onSelect(.blog) }
            )
            SegmentedTab(
                title: "이미지",
                isSelected: selected == .image,
                action: { onSelect(.image) }
            )
            SegmentedTab(
                title: "동영상",
                isSelected: selected == .video,
                action: { onSelect(.video) }
            )
            Spacer(minLength: 0)
        }
    }
}

private struct SegmentedTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .lineLimit(1)
                .padding(.horizontal, 12)
                .frame(height: 36, alignment: .center) // 높이 고정
                .background(isSelected ? Color.black : Color(.systemGray5))
                .foregroundColor(isSelected ? .white : Color(.systemGray))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
