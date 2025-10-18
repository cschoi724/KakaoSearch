//
//  RecentSearchLocalDataSource.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Core

public protocol RecentSearchLocalDataSource {
    func save(_ query: String)
    func loadAll() -> [String]
    func clear()
}

public final class RecentSearchLocalDataSourceImpl: RecentSearchLocalDataSource {

    private let storage: KeyValueStorage
    private let key: String = PersistenceKey.recentSearches
    private let maxCount: Int

    public init(storage: KeyValueStorage, maxCount: Int = 20) {
        self.storage = storage
        self.maxCount = maxCount
    }

    public func save(_ query: String) {
        var list = loadAll()
        if let idx = list.firstIndex(of: query) { list.remove(at: idx) }
        list.insert(query, at: 0)
        if list.count > maxCount { list = Array(list.prefix(maxCount)) }
        storage.set(list, forKey: key)
    }

    public func loadAll() -> [String] {
        storage.value(forKey: key, as: [String].self) ?? []
    }

    public func clear() {
        storage.removeValue(forKey: key)
    }
}
