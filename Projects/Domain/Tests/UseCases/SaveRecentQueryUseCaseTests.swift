//
//  SaveRecentQueryUseCaseTests.swift
//  Domain
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Domain

final class SaveRecentQueryUseCaseTests: XCTestCase {

    // 1) 저장 요청이 전달되고, 저장 직후 전체 목록이 반환되는지
    func test_execute_savesQuery_andReturnsAll() {
        let repo = RecentSearchRepositoryStub()
        let sut = SaveRecentQueryUseCaseImpl(repo: repo)
        
        let list1 = sut("swift")
        let list2 = sut("tca")

        XCTAssertEqual(repo.savedQueries, ["swift", "tca"])
        XCTAssertEqual(list1, ["swift"])
        XCTAssertEqual(list2, ["swift", "tca"])
    }
}
