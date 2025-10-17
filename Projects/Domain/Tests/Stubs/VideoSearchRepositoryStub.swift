//
//  VideoSearchRepositoryStub.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
@testable import Domain

final class VideoSearchRepositoryStub: VideoSearchRepository {
    var items: [VideoItem] = []
    var pageInfo: PageInfo = .init(isEnd: true, totalCount: nil)
    var error: Error? = nil
    let state = State()

    func searchVideos(query: String, page: Int, size: Int) async throws -> ([VideoItem], PageInfo) {
        await state.update(query: query, page: page, size: size)
        if let error { throw error }
        return (items, pageInfo)
    }
}

extension VideoSearchRepositoryStub {
    actor State {
        var callCount = 0
        var receivedQueries: [String] = []
        var receivedPages: [Int] = []
        var receivedSizes: [Int] = []
        
        func update(query: String, page: Int, size: Int) {
            callCount += 1
            receivedQueries.append(query)
            receivedPages.append(page)
            receivedSizes.append(size)
        }
    }
}
