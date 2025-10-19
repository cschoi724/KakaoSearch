//
//  OtherImagesGrid.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Domain

struct OtherImagesGrid: View {
    let items: [ImageItem]
    var onTap: (ImageItem) -> Void
    private let horizontalPadding: CGFloat = 16
    private let interItemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16
    
    private let columns: [GridItem] = [
        GridItem(
            .flexible(minimum: 0, maximum: .infinity),
            spacing: 12
        ),
        GridItem(
            .flexible(minimum: 0, maximum: .infinity),
            spacing: 12
        )
    ]

    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let cellWidth = (totalWidth - (horizontalPadding * 2) - interItemSpacing) / 2
            LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                ForEach(items, id: \.imageUrl) { item in
                    ImageCardView(item: item, width: cellWidth)
                        .onTapGesture {
                            onTap(item)
                        }
                }
            }
        }
    }
}
