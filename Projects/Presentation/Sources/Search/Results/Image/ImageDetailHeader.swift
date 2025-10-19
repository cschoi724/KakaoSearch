//
//  ImageDetailHeader.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ImageDetailHeader: View {
    var backTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: backTapped) {
                Image("icn_back", bundle: .presentation)
                    .renderingMode(.original)
                    .foregroundColor(.primary)
                    .frame(width: 24, height: 24)
                    .padding(12)
            }
            Spacer()
        }
        .padding(.horizontal, 4)
    }
}
