//
//  SaveRecentQueryUseCase.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct SaveRecentQueryUseCase {
    private let repo: RecentSearchRepository

    public init(repo: RecentSearchRepository) { self.repo = repo }

    @discardableResult
    public func callAsFunction(_ query: String) -> [String] {
        repo.save(query)
        return repo.loadAll()
    }
}
