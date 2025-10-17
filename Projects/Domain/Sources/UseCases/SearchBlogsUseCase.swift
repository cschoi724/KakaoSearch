//
//  SearchBlogsUseCase.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
// 블로그 검색
public protocol SearchBlogsUseCase: Sendable {
  @discardableResult
  func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([BlogItem], PageInfo)
}

public final class DefaultSearchBlogsUseCase: SearchBlogsUseCase {
  private let repository: BlogSearchRepository

  public init(repository: BlogSearchRepository) {
    self.repository = repository
  }

  public func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([BlogItem], PageInfo) {
    try await repository.searchBlogs(query: query, page: page, size: size)
  }
}
