//
//  ImageHeroImageCard.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct ImageHeroImageCard: View {
    let item: ImageItem

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            CommonImage(source: .remote(item.imageUrl))
                .aspectRatio(
                    CGFloat(item.width) / max(1, CGFloat(item.height)),
                    contentMode: .fit
                )
            Text("\(item.width) x \(item.height)")
                .font(.caption2)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.55))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                .padding(8)
        }
    }
}
