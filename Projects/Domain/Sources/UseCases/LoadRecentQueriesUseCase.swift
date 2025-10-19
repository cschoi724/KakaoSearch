//
//  LoadRecentQueriesUseCase.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public protocol LoadRecentQueriesUseCase {
    @discardableResult
    func callAsFunction() -> [String]
}

public struct LoadRecentQueriesUseCaseImpl: LoadRecentQueriesUseCase {
    private let repo: RecentSearchRepository

    public init(repo: RecentSearchRepository) { self.repo = repo }

    public func callAsFunction() -> [String] {
        repo.loadAll()
    }
}
