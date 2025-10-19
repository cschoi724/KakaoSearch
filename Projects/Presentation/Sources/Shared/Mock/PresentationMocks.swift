//
//  PresentationMocks.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

#if DEBUG
import Foundation
import Domain

public struct PreviewSaveRecentQueryUseCase: SaveRecentQueryUseCase {
    public init() {}

    @discardableResult
    public func callAsFunction(_ query: String) -> [String] {
        ["kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca"]
    }
}

public struct PreviewLoadRecentQueriesUseCase: LoadRecentQueriesUseCase {
    public init() {}
    public func callAsFunction() -> [String] {
        ["kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca", "kakao", "swift", "tca"]
    }
}

public struct PreviewSearchBlogsUseCase: SearchBlogsUseCase {
    public init() {}

    public func callAsFunction(_ request: SearchRequest) async throws -> ([BlogItem], PageInfo) {
        var items: [BlogItem] = []
        for _ in 0...100 {
            items.append(
                BlogItem(
                    title: "블로그 예시",
                    contents: "내용 예시",
                    blogName: "예시 블로그",
                    url: "https://example.com/1",
                    thumbnail: "https://picsum.photos/200",
                    datetime: "2025-10-19T00:00:00Z"
                )
            )
        }

        let pageInfo = PageInfo(
            isEnd: false,
            pageableCount: 1,
            totalCount: 101
        )

        return (items, pageInfo)
    }
}

public struct PreviewSearchImagesUseCase: SearchImagesUseCase {
    public init() {}

    public func callAsFunction(_ request: SearchRequest) async throws -> ([ImageItem], PageInfo) {
        var items: [ImageItem] = []
        for _ in 0...100 {
            items.append(
                ImageItem(
                    collection: "etc",
                    thumbnailUrl: "https://picsum.photos/200",
                    imageUrl: "https://picsum.photos/800",
                    width: 800,
                    height: 600,
                    displaySiteName: "picsum",
                    docUrl: "https://example.com/i1",
                    datetime: "2025-10-19T00:00:00Z"
                )
            )
        }
        let pageInfo = PageInfo(
            isEnd: true,
            pageableCount: 1,
            totalCount: 1
        )

        return (items, pageInfo)
    }
}

public struct PreviewSearchVideosUseCase: SearchVideosUseCase {
    public init() {}

    public func callAsFunction(_ request: SearchRequest) async throws -> ([VideoItem], PageInfo) {
        var items: [VideoItem] = []
        for _ in 0...100 {
            items.append(
                VideoItem(
                    title: "동영상 예시",
                    url: "https://example.com/v1",
                    datetime: "2025-10-19T00:00:00Z",
                    playTime: 123,
                    thumbnail: "https://picsum.photos/300",
                    author: "예시 채널"
                )
            )
        }

        let pageInfo = PageInfo(
            isEnd: true,
            pageableCount: 1,
            totalCount: 1
        )

        return (items, pageInfo)
    }
}

#endif
