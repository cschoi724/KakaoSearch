//
//  ImageSearchRepository.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

public protocol ImageSearchRepository: Sendable {
    func searchImages(_ request: SearchRequest) async throws -> ([ImageItem], PageInfo)
}
