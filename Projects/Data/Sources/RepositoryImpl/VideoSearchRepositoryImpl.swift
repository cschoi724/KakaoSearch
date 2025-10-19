//
//  VideoSearchRepositoryImpl.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public final class VideoSearchRepositoryImpl: VideoSearchRepository, @unchecked Sendable {
   
    private let remote: VideoRemoteDataSource

    public init(remote: VideoRemoteDataSource) {
        self.remote = remote
    }

    public func searchVideos(_ request: SearchRequest) async throws -> ([VideoItem], PageInfo) {
        let response: SearchResponseDTO<VideoDocumentDTO> = try await remote.fetchVideos(request)
        let items = response.documents.map { $0.toDomain() }
        let pageInfo = PageInfo(
            isEnd: response.meta.isEnd,
            pageableCount: response.meta.pageableCount,
            totalCount: response.meta.totalCount
        )
        return (items, pageInfo)
    }
}
