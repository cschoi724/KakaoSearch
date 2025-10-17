//
//  ImageSearchRepository.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

public protocol ImageSearchRepository {
  func searchImages(query: String, page: Int, size: Int) async throws -> ([ImageItem], PageInfo)
}
