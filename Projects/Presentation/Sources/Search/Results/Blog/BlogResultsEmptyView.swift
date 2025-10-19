//
//  BlogResultsEmptyView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct BlogResultsEmptyView: View {
    let onRefresh: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("검색 결과가 없습니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button("다시 시도") {
                onRefresh()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}
