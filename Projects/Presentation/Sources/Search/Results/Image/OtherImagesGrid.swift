//
//  OtherImagesGrid.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//
import SwiftUI
import Domain

struct OtherImagesGrid: View {
    let items: [ImageItem]
    var onTap: (ImageItem) -> Void

    private let horizontalPadding: CGFloat = 16
    private let interItemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16

    var body: some View {
        let totalWidth = UIScreen.main.bounds.width
        let cellWidth = (totalWidth - (horizontalPadding * 2) - interItemSpacing) / 2

        LazyVGrid(
            columns: [
                GridItem(.fixed(cellWidth), spacing: interItemSpacing),
                GridItem(.fixed(cellWidth), spacing: interItemSpacing)
            ],
            alignment: .center,
            spacing: lineSpacing
        ) {
            ForEach(items, id: \.imageUrl) { item in
                ImageCardView(item: item, width: cellWidth)
                    .contentShape(Rectangle())
                    .onTapGesture { onTap(item) }
            }
        }
    }
}
