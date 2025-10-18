//
//  RecentSearchRepositoryStub.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//


import Foundation
@testable import Domain

final class RecentSearchRepositoryStub: RecentSearchRepository {

    private(set) var savedQueries: [String] = []

    func save(_ query: String) {
        savedQueries.append(query)
    }

    func loadAll() -> [String] {
        savedQueries
    }

    func clear() {
        savedQueries.removeAll()
    }
}
