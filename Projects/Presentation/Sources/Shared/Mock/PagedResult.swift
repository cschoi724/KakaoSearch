//
//  PagedResult.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct PagedResult<Item> {
    public let items: [Item]
    public let pageInfo: PageInfo

    public init(items: [Item], pageInfo: PageInfo) {
        self.items = items
        self.pageInfo = pageInfo
    }

    public struct PageInfo {
        public let totalCount: Int
        public let pageableCount: Int
        public let isEnd: Bool

        public init(totalCount: Int, pageableCount: Int, isEnd: Bool) {
            self.totalCount = totalCount
            self.pageableCount = pageableCount
            self.isEnd = isEnd
        }
    }
}
