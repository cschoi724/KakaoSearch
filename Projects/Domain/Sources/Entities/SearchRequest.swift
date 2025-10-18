//
//  SearchRequest.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct SearchRequest: Sendable, Equatable {
    public let query: String
    public let sort: String
    public let page: Int
    public let size: Int

    public init(
        query: String,
        sort: String,
        page: Int,
        size: Int
    ) {
        self.query = query
        self.sort = sort
        self.page = page
        self.size = size
    }
}
