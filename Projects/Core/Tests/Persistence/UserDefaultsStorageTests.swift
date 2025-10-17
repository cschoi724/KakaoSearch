//
//  UserDefaultsStorageTests.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Core

final class UserDefaultsStorageTests: XCTestCase {

    private var storage: KeyValueStorage!
    private var suiteName: String!

    override func setUp() {
        super.setUp()
        suiteName = "com.annyeongjelly.kakaosearch.tests.\(UUID().uuidString)"
        storage = UserDefaultsStorage(suiteName: suiteName)
        storage.removeAll()
    }

    override func tearDown() {
        storage.removeAll()
        storage = nil
        suiteName = nil
        super.tearDown()
    }

    //단순 타입 저장/복원 테스트
    func test_setAndGet_Primitive() {
        storage.set(123, forKey: "int")
        let value: Int? = storage.value(forKey: "int", as: Int.self)
        XCTAssertEqual(value, 123)
    }

    // Codable 객체 저장/복원 테스트
    func test_setAndGet_CodableRoundTrip() {
        let payload = Profile(id: "u1", name: "Alice", age: 30)
        storage.set(payload, forKey: "profile")
        let decoded: Profile? = storage.value(forKey: "profile", as: Profile.self)
        XCTAssertEqual(decoded, payload)
    }

    // 기존 키 덮어쓰기 테스트
    func test_overrideExistingValue() {
        storage.set("old", forKey: "k")
        storage.set("new", forKey: "k")
        let value: String? = storage.value(forKey: "k", as: String.self)
        XCTAssertEqual(value, "new")
    }

    // 특정 키 삭제 테스트
    func test_removeValue() {
        storage.set(true, forKey: "flag")
        storage.removeValue(forKey: "flag")
        let value: Bool? = storage.value(forKey: "flag", as: Bool.self)
        XCTAssertNil(value)
    }

    // 전체 삭제 테스트
    func test_removeAll() {
        storage.set(1, forKey: "a")
        storage.set(2, forKey: "b")
        storage.removeAll()
        let a: Int? = storage.value(forKey: "a", as: Int.self)
        let b: Int? = storage.value(forKey: "b", as: Int.self)
        XCTAssertNil(a)
        XCTAssertNil(b)
    }

    // 존재하지 않는 키 조회 테스트
    func test_missingKey_returnsNil() {
        let value: String? = storage.value(forKey: "nope", as: String.self)
        XCTAssertNil(value)
    }

    // suiteName 격리 테스트
    func test_suiteName_isIsolated() {
        storage.set("v", forKey: "iso")

        let other = UserDefaultsStorage(suiteName: "com.annyeongjelly.kakaosearch.tests.\(UUID().uuidString)")
        let read: String? = other.value(forKey: "iso", as: String.self)

        XCTAssertNil(read, "다른 suiteName에서는 값이 보이면 안 됨")
    }
}

private struct Profile: Codable, Equatable {
    let id: String
    let name: String
    let age: Int
}
