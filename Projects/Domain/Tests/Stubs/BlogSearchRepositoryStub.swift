//
//  BlogSearchRepositoryStub.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
@testable import Domain

final class BlogSearchRepositoryStub: BlogSearchRepository, @unchecked Sendable {
    var items: [BlogItem] = []
    var pageInfo: PageInfo = .init(isEnd: true, pageableCount: 0, totalCount: 0)
    var error: Error? = nil
    let state = State()

    func searchBlogs(_ request: SearchRequest) async throws -> ([BlogItem], PageInfo) {
        await state.update(request: request)
        if let error { throw error }
        return (items, pageInfo)
    }
}

extension BlogSearchRepositoryStub {
    actor State {
        var callCount = 0
        var receivedRequests: [SearchRequest] = []

        func update(request: SearchRequest) {
            callCount += 1
            receivedRequests.append(request)
        }
    }

}
