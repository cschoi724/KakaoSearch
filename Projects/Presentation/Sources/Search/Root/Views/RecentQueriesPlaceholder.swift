//
//  RecentQueriesPlaceholder.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct RecentQueriesPlaceholder: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("최근 검색어")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            Text("최근 검색어가 없습니다.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
    }
}
