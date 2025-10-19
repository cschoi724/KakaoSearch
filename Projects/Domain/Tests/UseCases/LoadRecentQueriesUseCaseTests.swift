//
//  LoadRecentQueriesUseCaseTests.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Domain

final class LoadRecentQueriesUseCaseTests: XCTestCase {

    // 1) 저장된 목록이 그대로 반환되는지
    func test_execute_returnsAllSavedQueries() {
        let repo = RecentSearchRepositoryStub()
        repo.save("swift")
        repo.save("tca")
        let sut = LoadRecentQueriesUseCaseImpl(repo: repo)
        let list = sut()
        XCTAssertEqual(list, ["swift", "tca"])
    }

    // 2) 저장 데이터가 없으면 빈 배열을 반환하는지
    func test_execute_returnsEmptyWhenNoData() {
        let repo = RecentSearchRepositoryStub()
        let sut = LoadRecentQueriesUseCaseImpl(repo: repo)
        let list = sut()
        XCTAssertTrue(list.isEmpty)
    }
}
