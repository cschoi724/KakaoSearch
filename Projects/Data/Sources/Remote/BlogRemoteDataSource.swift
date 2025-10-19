//
//  BlogRemoteDataSource.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public protocol BlogRemoteDataSource {
    func fetchBlogs(_ request: SearchRequest) async throws -> SearchResponseDTO<BlogDocumentDTO>
}

public final class BlogRemoteDataSourceImpl: BlogRemoteDataSource {
    private let client: NetworkClient
    public init(client: NetworkClient) { self.client = client }

    public func fetchBlogs(_ request: SearchRequest) async throws -> SearchResponseDTO<BlogDocumentDTO> {
        do {
            return try await client.request(
                KakaoAPIEndpoint.blog(request),
                decoder: JSONCoding.baselineDecoder
            )
        } catch {
            throw KakaoAPIErrorMapper.map(error)
        }
    }
}
