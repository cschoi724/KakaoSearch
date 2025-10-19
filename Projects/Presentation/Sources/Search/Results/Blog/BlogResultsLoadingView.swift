//
//  BlogResultsLoadingView.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct BlogResultsLoadingView: View {
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("불러오는 중…")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
    }
}
