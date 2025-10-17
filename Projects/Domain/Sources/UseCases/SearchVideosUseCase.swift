//
//  SearchVideosUseCase.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
// 비디오 검색
public protocol SearchVideosUseCase: Sendable {
  @discardableResult
  func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([VideoItem], PageInfo)
}

public final class DefaultSearchVideosUseCase: SearchVideosUseCase {
  private let repository: VideoSearchRepository

  public init(repository: VideoSearchRepository) {
    self.repository = repository
  }

  public func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([VideoItem], PageInfo) {
    try await repository.searchVideos(query: query, page: page, size: size)
  }
}
