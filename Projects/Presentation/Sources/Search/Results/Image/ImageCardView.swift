//
//  ImageCardView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import Domain

struct ImageCardView: View {
    let item: ImageItem
    let width: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            let w = CGFloat(item.width)
            let h = CGFloat(item.height)
            let ratio = (w > 0 && h > 0) ? (h / w) : 1.0
            let height = width * ratio
            
            CommonImage(source: .remote(item.thumbnailUrl))
                .scaledToFill()
                //.aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            HStack(spacing: 6) {
                Text("\(item.displaySiteName ?? "출처 없음")")
                if let dt = item.datetime {
                    Text("·")
                    Text(dt.kakaoDateTime())
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .lineLimit(1)
        }
    }
}
