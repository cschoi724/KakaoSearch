//
//  SearchImagesUseCaseTests.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Domain

final class SearchImagesUseCaseTests: XCTestCase {

    // 1) 성공 기본 흐름
    func test_success_returnsItemsAndPageInfo() async throws {
        let repo = ImageSearchRepositoryStub()
        repo.items = [
            .init(
                collection: "etc",
                thumbnailUrl: "https://example.com/thumb.png",
                imageUrl: "https://example.com/full.png",
                width: 120,
                height: 80,
                displaySiteName: "네이버",
                docUrl: "https://naver.com",
                datetime: "2025-10-18T00:00:00+09:00"
            )
        ]
        repo.pageInfo = .init(isEnd: false, pageableCount: 10, totalCount: 50)
        let sut = DefaultSearchImagesUseCase(repository: repo)

        let request = SearchRequest(query: "강아지", sort: "accuracy", page: 1, size: 10)
        let (items, page) = try await sut(request)

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.collection, "etc")
        XCTAssertFalse(page.isEnd)
        XCTAssertEqual(page.totalCount, 50)
        XCTAssertEqual(page.pageableCount, 10)
    }

    // 2) 빈 결과
    func test_empty_returnsEmptyAndEndTrue() async throws {
        let repo = ImageSearchRepositoryStub()
        repo.items = []
        repo.pageInfo = .init(isEnd: true, pageableCount: 0, totalCount: 0)
        let sut = DefaultSearchImagesUseCase(repository: repo)

        let request = SearchRequest(query: "없는키워드", sort: "accuracy", page: 1, size: 10)
        let (items, page) = try await sut(request)

        XCTAssertTrue(items.isEmpty)
        XCTAssertTrue(page.isEnd)
        XCTAssertEqual(page.totalCount, 0)
    }

    // 3) 에러 전파
    func test_error_isPropagated() async {
        enum StubError: Error, Equatable { case boom }
        let repo = ImageSearchRepositoryStub()
        repo.error = StubError.boom
        let sut = DefaultSearchImagesUseCase(repository: repo)

        let request = SearchRequest(query: "에러", sort: "accuracy", page: 1, size: 10)
        do {
            _ = try await sut(request)
            XCTFail("에러가 발생해야 함")
        } catch let e as StubError {
            XCTAssertEqual(e, .boom)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // 4) 파라미터 전달 검증
    func test_parameters_arePassedThroughToRepository() async throws {
        let repo = ImageSearchRepositoryStub()
        let sut = DefaultSearchImagesUseCase(repository: repo)

        let request = SearchRequest(query: "고양이", sort: "accuracy", page: 2, size: 30)
        _ = try await sut(request)

        let callCount = await repo.state.callCount
        let receivedRequests = await repo.state.receivedRequests

        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(receivedRequests.map { $0.query }, ["고양이"])
        XCTAssertEqual(receivedRequests.map { $0.page }, [2])
        XCTAssertEqual(receivedRequests.map { $0.size }, [30])
        XCTAssertEqual(receivedRequests.map { $0.sort }, ["accuracy"])
    }

    // 5) 동시성
    func test_concurrentCalls_doNotCrash() async throws {
        let repo = ImageSearchRepositoryStub()
        repo.items = (0..<3).map {
            .init(
                collection: "img\($0)",
                thumbnailUrl: "https://thumb/\($0)",
                imageUrl: "https://img/\($0)",
                width: 100,
                height: 100,
                displaySiteName: nil,
                docUrl: nil,
                datetime: nil
            )
        }
        repo.pageInfo = .init(isEnd: false, pageableCount: 3, totalCount: 3)
        let sut = DefaultSearchImagesUseCase(repository: repo)

        let req = SearchRequest(query: "동시성", sort: "accuracy", page: 1, size: 5)
        async let r1 = sut(req)
        async let r2 = sut(req)
        async let r3 = sut(req)
        let results = try await [r1, r2, r3]

        let callCount = await repo.state.callCount
        XCTAssertEqual(callCount, 3)
        XCTAssertEqual(results.count, 3)
    }
}
