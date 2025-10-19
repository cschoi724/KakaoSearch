//
//  ImageRemoteDataSource.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public protocol ImageRemoteDataSource {
    func fetchImages(_ request: SearchRequest) async throws -> SearchResponseDTO<ImageDocumentDTO>
}

public final class ImageRemoteDataSourceImpl: ImageRemoteDataSource {
    private let client: NetworkClient
    public init(client: NetworkClient) { self.client = client }

    public func fetchImages(_ request: SearchRequest) async throws -> SearchResponseDTO<ImageDocumentDTO> {
        do {
            return try await client.request(
                KakaoAPIEndpoint.image(request),
                decoder: JSONCoding.baselineDecoder
            )
        } catch {
            throw KakaoAPIErrorMapper.map(error)
        }
    }
}
