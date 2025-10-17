//
//  UserDefaultsStorage.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public final class UserDefaultsStorage: KeyValueStorage {

    private let defaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    public init(
        suiteName: String? = nil,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        if let suiteName {
            self.defaults = UserDefaults(suiteName: suiteName) ?? .standard
        } else {
            self.defaults = .standard
        }
        self.encoder = encoder
        self.decoder = decoder
    }

    public func value<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    public func set<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try encoder.encode(value)
            defaults.set(data, forKey: key)
        } catch {
        }
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }

    public func removeAll() {
        defaults.dictionaryRepresentation().keys.forEach { defaults.removeObject(forKey: $0) }
    }
}
