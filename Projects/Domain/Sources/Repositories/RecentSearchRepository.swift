//
//  RecentSearchRepository.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public protocol RecentSearchRepository {
    func save(_ query: String)
    func loadAll() -> [String]
    func clear()
}
