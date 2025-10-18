//
//  VideoRemoteDataSource.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public protocol VideoRemoteDataSource {
    func fetchVideos(_ request: SearchRequest) async throws -> SearchResponseDTO<VideoDocumentDTO>
}

public final class VideoRemoteDataSourceImpl: VideoRemoteDataSource {
    private let client: NetworkClient
    public init(client: NetworkClient) { self.client = client }

    public func fetchVideos(_ request: SearchRequest) async throws -> SearchResponseDTO<VideoDocumentDTO> {
        do {
            return try await client.request(
                KakaoAPIEndpoint.video(request),
                decoder: JSONCoding.baselineDecoder
            )
        } catch {
            throw KakaoAPIErrorMapper.map(error)
        }
    }
}
