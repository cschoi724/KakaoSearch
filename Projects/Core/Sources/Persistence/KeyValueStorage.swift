//
//  KeyValueStorage.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public protocol KeyValueStorage {
    func value<T: Codable>(forKey key: String, as type: T.Type) -> T?
    func set<T: Codable>(_ value: T, forKey key: String)
    func removeValue(forKey key: String)
    func removeAll()
}
