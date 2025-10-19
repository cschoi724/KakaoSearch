//
//  VideoRowView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct VideoRowView: View {
    let item: VideoItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                GeometryReader { proxy in
                    CommonImage(source: .remote(item.thumbnail ?? item.url))
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.width * 9 / 16
                        )
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(alignment: .center) {
                            Image("icon_play", bundle: .presentation)
                                .resizable()
                                .frame(width: 48, height: 48)
                                .opacity(0.85)
                        }
                        .overlay(alignment: .bottomTrailing) {
                            Text(item.playTime.kakaoPlayTime())
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.lightGray))
                                .padding(8)
                        }
                }
                .aspectRatio(16/9, contentMode: .fit)
            }

            Text(item.title)
                .font(.headline)
                .foregroundStyle(.primary)
                .lineLimit(2)

            HStack(spacing: 6) {
                Text(item.author ?? "동영상 업로더")
                Text("·")
                Text(item.datetime?.kakaoDateTime() ?? "-")
                
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
            .lineLimit(1)
        }
        .padding(.vertical, 8)
    }
}
