//
//  SearchHeader.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct SearchHeader: View {
    @Binding var text: String
    var onSubmit: () -> Void
    var onClear: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Image("icn_search", bundle: .presentation)
                .renderingMode(.original)
                .frame(width: 20, height: 20)

            SearchTextField(
                text: $text,
                placeholder: "상품, 서비스 검색",
                onSubmit: onSubmit
            )

            if !text.isEmpty {
                Button(action: onClear) {
                    Image("icn_delete", bundle: .presentation)
                        .renderingMode(.original)
                        .frame(width: 18, height: 18)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }
}
