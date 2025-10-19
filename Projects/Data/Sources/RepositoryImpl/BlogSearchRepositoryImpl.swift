//
//  BlogSearchRepositoryImpl.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public final class BlogSearchRepositoryImpl: BlogSearchRepository, @unchecked Sendable {

    private let remote: BlogRemoteDataSource

    public init(remote: BlogRemoteDataSource) {
        self.remote = remote
    }

    public func searchBlogs(_ request: SearchRequest) async throws -> ([BlogItem], PageInfo) {
        let response: SearchResponseDTO<BlogDocumentDTO> = try await remote.fetchBlogs(request)
        let items = response.documents.map { $0.toDomain() }
        let pageInfo = PageInfo(
            isEnd: response.meta.isEnd,
            pageableCount: response.meta.pageableCount,
            totalCount: response.meta.totalCount
        )
        return (items, pageInfo)
    }
}
