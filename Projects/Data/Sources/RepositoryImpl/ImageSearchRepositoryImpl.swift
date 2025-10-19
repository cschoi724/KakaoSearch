//
//  ImageSearchRepositoryImpl.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public final class ImageSearchRepositoryImpl: ImageSearchRepository, @unchecked Sendable {

    private let remote: ImageRemoteDataSource

    public init(remote: ImageRemoteDataSource) {
        self.remote = remote
    }

    public func searchImages(_ request: SearchRequest) async throws -> ([ImageItem], PageInfo) {
        let response: SearchResponseDTO<ImageDocumentDTO> = try await remote.fetchImages(request)
        let items = response.documents.map { $0.toDomain() }
        let pageInfo = PageInfo(
            isEnd: response.meta.isEnd,
            pageableCount: response.meta.pageableCount,
            totalCount: response.meta.totalCount
        )
        return (items, pageInfo)
    }
}
