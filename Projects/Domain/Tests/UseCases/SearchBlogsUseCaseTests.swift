//
//  SearchBlogsUseCaseTests.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Domain

final class SearchBlogsUseCaseTests: XCTestCase {

    // 1) 성공 기본 흐름
    func test_success_returnsItemsAndPageInfo() async throws {
        let repo = BlogSearchRepositoryStub()
        repo.items = [
            .init(
                title: "테스트 블로그 제목",
                contents: "내용 요약",
                blogName: "블로그이름",
                url: "https://example.com/1",
                thumbnail: "https://example.com/t1.png",
                datetime: "2025-10-18T00:00:00+09:00"
            )
        ]
        repo.pageInfo = .init(isEnd: false, pageableCount: 12, totalCount: 123)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        let (items, page) = try await sut(.init(query: "고양이", sort: "accuracy", page: 1, size: 10))

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.title, "테스트 블로그 제목")
        XCTAssertFalse(page.isEnd)
        XCTAssertEqual(page.totalCount, 123)
        XCTAssertEqual(page.pageableCount, 12)
    }

    // 2) 빈 결과
    func test_empty_returnsEmptyAndEndTrue() async throws {
        let repo = BlogSearchRepositoryStub()
        repo.items = []
        repo.pageInfo = .init(isEnd: true, pageableCount: 0, totalCount: 0)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        let (items, page) = try await sut(.init(query: "없는키워드", sort: "accuracy", page: 1, size: 10))

        XCTAssertTrue(items.isEmpty)
        XCTAssertTrue(page.isEnd)
        XCTAssertEqual(page.totalCount, 0)
    }

    // 3) 에러 전파
    func test_error_isPropagated() async {
        enum StubError: Error, Equatable { case boom }
        let repo = BlogSearchRepositoryStub()
        repo.error = StubError.boom
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        do {
          _ = try await sut(.init(query: "에러키워드", sort: "accuracy", page: 1, size: 10))
          XCTFail("에러가 발생해야 함")
        } catch let e as StubError {
          XCTAssertEqual(e, .boom)
        } catch {
          XCTFail("Unexpected error: \(error)")
        }
    }

    // 4) 파라미터 전달 검증
    func test_parameters_arePassedThroughToRepository() async throws {
        let repo = BlogSearchRepositoryStub()
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        _ = try await sut(.init(query: "강아지", sort: "recency", page: 3, size: 50))

        let callCount = await repo.state.callCount
        let requests = await repo.state.receivedRequests

        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(requests.count, 1)
        XCTAssertEqual(requests.first?.query, "강아지")
        XCTAssertEqual(requests.first?.sort, "recency")
        XCTAssertEqual(requests.first?.page, 3)
        XCTAssertEqual(requests.first?.size, 50)
    }

    // 5) 동시성
    func test_concurrentCalls_doNotCrash() async throws {
        let repo = BlogSearchRepositoryStub()
        repo.items = (0..<5).map { i in
            .init(
                title: "제목 \(i)",
                contents: "요약 \(i)",
                blogName: "블로그",
                url: "https://example.com/\(i)",
                thumbnail: "",
                datetime: ""
            )
        }
        repo.pageInfo = .init(isEnd: false, pageableCount: 5, totalCount: 5)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        async let r1 = sut(.init(query: "동시성", sort: "accuracy", page: 1, size: 5))
        async let r2 = sut(.init(query: "동시성", sort: "accuracy", page: 2, size: 5))
        async let r3 = sut(.init(query: "동시성", sort: "accuracy", page: 3, size: 5))
        let results = try await [r1, r2, r3]
        let callCount = await repo.state.callCount
        XCTAssertEqual(callCount, 3)
        XCTAssertEqual(results.count, 3)
    }
}
