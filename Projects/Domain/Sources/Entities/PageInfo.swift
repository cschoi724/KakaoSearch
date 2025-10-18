//
//  PageInfo.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

public struct PageInfo: Equatable, Sendable {
    public let isEnd: Bool
    public let pageableCount: Int
    public let totalCount: Int

    public init(isEnd: Bool, pageableCount: Int, totalCount: Int) {
        self.isEnd = isEnd
        self.pageableCount = pageableCount
        self.totalCount = totalCount
    }
}
