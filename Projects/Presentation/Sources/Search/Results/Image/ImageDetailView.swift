//
//  ImageDetailView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Domain

public struct ImageDetailView: View {
    let store: StoreOf<ImageDetailFeature>
    @Environment(\.dismiss) private var dismiss
    
    public init(store: StoreOf<ImageDetailFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ImageDetailHeader(
                        backTapped: { dismiss() }
                    )
                    ImageHeroImageCard(item: viewStore.selected)
                    HStack(spacing: 6) {
                        Text("\(viewStore.selected.displaySiteName ?? "출처 없음")")
                        if let dt = viewStore.selected.datetime {
                            Text("·")
                            Text(dt.kakaoDateTime())
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .padding(.horizontal, 16)
                    Rectangle()
                        .fill(Color(.systemGray6))
                        .frame(height: 4)
                    Text("결과 내 다른 이미지")
                        .font(.headline)
                        .padding(.horizontal, 16)
                    OtherImagesGrid(
                        items: viewStore.relatedImages,
                        onTap: { viewStore.send(.imageTapped($0)) }
                    )
                    .padding(.horizontal, 16)
                }
                .padding(.top, 8)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
