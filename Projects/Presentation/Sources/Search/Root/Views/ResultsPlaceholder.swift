//
//  ResultsPlaceholder.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct ResultsPlaceholder: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("검색 결과")
                .font(.headline)
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 4) {
                ForEach(0..<3) { i in
                    HStack {
                        Image("icn_spinner")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("결과 \(i + 1)")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
    }
}
