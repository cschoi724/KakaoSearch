//
//  SearchResultsContent.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SearchResultsContent: View {
    let store: StoreOf<SearchResultsFeature>
    let selected: SearchResultsFeature.State.Tab

    var body: some View {
        switch selected {
        case .blog:
            BlogResultsView(
                store: store.scope(
                    state: \.blog,
                    action: SearchResultsFeature.Action.blog
                )
            )
        case .image:
            ImageResultsView(
                store: store.scope(
                    state: \.image,
                    action: SearchResultsFeature.Action.image
                )
            )
        case .video:
            VideoResultsView(
                store: store.scope(
                    state: \.video,
                    action: SearchResultsFeature.Action.video
                )
            )
        }
    }
}
