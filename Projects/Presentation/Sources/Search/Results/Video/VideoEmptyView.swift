//
//  VideoEmptyView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct VideoEmptyView: View {
    let query: String
    let isLoading: Bool

    var body: some View {
        VStack(spacing: 8) {
            if isLoading {
                ProgressView().padding(.bottom, 4)
                Text("검색 중…").font(.subheadline).foregroundColor(.secondary)
            } else if query.isEmpty {
                Text("검색어를 입력하고 검색을 시작하세요")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("“\(query)”에 대한 결과가 없습니다")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
