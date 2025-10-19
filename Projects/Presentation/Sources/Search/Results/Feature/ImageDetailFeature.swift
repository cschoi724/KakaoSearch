//
//  ImageDetailFeature.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Domain

public struct ImageDetailFeature: Reducer {

    public struct State: Equatable {
        public var selected: ImageItem
        public var relatedImages: [ImageItem]

        public init(selected: ImageItem, relatedImages: [ImageItem]) {
            self.selected = selected
            self.relatedImages = relatedImages
        }
    }

    public enum Action: Equatable {
        case onAppear
        case imageTapped(ImageItem)
        case closeButtonTapped
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case let .imageTapped(item):
                state.selected = item
                return .none

            case .closeButtonTapped:
                return .none
            }
        }
    }
}
