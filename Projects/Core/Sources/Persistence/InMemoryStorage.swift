//
//  InMemoryStorage.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public final class InMemoryStorage: KeyValueStorage {

    private var store: [String: Data] = [:]
    private let lock = NSLock()
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }

    public func value<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        lock.lock(); defer { lock.unlock() }
        guard let data = store[key] else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    public func set<T: Codable>(_ value: T, forKey key: String) {
        lock.lock(); defer { lock.unlock() }
        guard let data = try? encoder.encode(value) else { return }
        store[key] = data
    }

    public func removeValue(forKey key: String) {
        lock.lock(); defer { lock.unlock() }
        store.removeValue(forKey: key)
    }

    public func removeAll() {
        lock.lock(); defer { lock.unlock() }
        store.removeAll()
    }
}
