//
//  BlogSearchRepository.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

public protocol BlogSearchRepository: Sendable {
    func searchBlogs(_ request: SearchRequest) async throws -> ([BlogItem], PageInfo)
}
