//
//  SearchResultsFeature.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

public struct SearchResultsFeature: Reducer {

    public struct State: Equatable {
        public var selectedTab: Tab = .blog
        public var blog = BlogResultsFeature.State()
        public var image = ImageResultsFeature.State()
        public var video = VideoResultsFeature.State()

        public enum Tab: Equatable { case blog, image, video }

        public init() {}
    }

    public enum Action {
        case selectTab(State.Tab)
        case searchRequested(String)
        case blog(BlogResultsFeature.Action)
        case image(ImageResultsFeature.Action)
        case video(VideoResultsFeature.Action)
    }

    public struct Environment: Sendable {
        public var blogEnv: BlogResultsFeature.Environment
        public var imageEnv: ImageResultsFeature.Environment
        public var videoEnv: VideoResultsFeature.Environment

        public init(
            blogEnv: BlogResultsFeature.Environment,
            imageEnv: ImageResultsFeature.Environment,
            videoEnv: VideoResultsFeature.Environment
        ) {
            self.blogEnv = blogEnv
            self.imageEnv = imageEnv
            self.videoEnv = videoEnv
        }
    }

    private let env: Environment

    public init(env: Environment) {
        self.env = env
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.blog, action: /Action.blog) {
            BlogResultsFeature(env: env.blogEnv)
        }
        Scope(state: \.image, action: /Action.image) {
            ImageResultsFeature(env: env.imageEnv)
        }
        Scope(state: \.video, action: /Action.video) {
            VideoResultsFeature(env: env.videoEnv)
        }

        Reduce { state, action in
            switch action {
            case let .selectTab(tab):
                state.selectedTab = tab
                return .none

            case let .searchRequested(query):
                return .concatenate(
                    .merge(
                        .send(.blog(.setQuery(query))),
                        .send(.image(.setQuery(query))),
                        .send(.video(.setQuery(query)))
                    ),
                    .merge(
                        .send(.blog(.submit)),
                        .send(.image(.submit)),
                        .send(.video(.submit))
                    )
                )

            case .blog, .image, .video:
                return .none
            }
        }
    }
}
