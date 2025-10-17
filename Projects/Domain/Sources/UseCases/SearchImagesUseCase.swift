//
//  SearchImagesUseCase.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
// 이미지 검색
public protocol SearchImagesUseCase: Sendable {
  @discardableResult
  func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([ImageItem], PageInfo)
}

public final class DefaultSearchImagesUseCase: SearchImagesUseCase {
  private let repository: ImageSearchRepository

  public init(repository: ImageSearchRepository) {
    self.repository = repository
  }

  public func callAsFunction(_ query: String, page: Int, size: Int) async throws -> ([ImageItem], PageInfo) {
    try await repository.searchImages(query: query, page: page, size: size)
  }
}
