//
//  RecentSearchRepositoryImpl.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain

public final class RecentSearchRepositoryImpl: RecentSearchRepository {
    private let local: RecentSearchLocalDataSource

    public init(local: RecentSearchLocalDataSource) {
        self.local = local
    }

    public func save(_ query: String) {
        local.save(query)
    }

    public func loadAll() -> [String] {
        local.loadAll()
    }

    public func clear() {
        local.clear()
    }
}
