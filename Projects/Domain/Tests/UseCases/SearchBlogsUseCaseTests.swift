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
            summary: "내용 요약",
            blogName: "블로그이름",
            url: URL(string: "https://example.com/1")!,
            thumbnailURL: URL(string: "https://example.com/t1.png"),
            datetime: Date()
          )
        ]
        repo.pageInfo = .init(isEnd: false, totalCount: 123)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        let (items, page) = try await sut("고양이", page: 1, size: 10)

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.title, "테스트 블로그 제목")
        XCTAssertFalse(page.isEnd)
        XCTAssertEqual(page.totalCount, 123)
    }

    // 2) 빈 결과
    func test_empty_returnsEmptyAndEndTrue() async throws {
        let repo = BlogSearchRepositoryStub()
        repo.items = []
        repo.pageInfo = .init(isEnd: true, totalCount: 0)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        let (items, page) = try await sut("없는키워드", page: 1, size: 10)

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
          _ = try await sut("에러키워드", page: 1, size: 10)
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

        _ = try await sut("강아지", page: 3, size: 50)

        let callCount = await repo.state.callCount
        let queries = await repo.state.receivedQueries
        let pages = await repo.state.receivedPages
        let sizes = await repo.state.receivedSizes
        
        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(queries, ["강아지"])
        XCTAssertEqual(pages, [3])
        XCTAssertEqual(sizes, [50])
    }

    // 5) 동시성
    func test_concurrentCalls_doNotCrash() async throws {        
        let repo = BlogSearchRepositoryStub()
        repo.items = (0..<5).map { i in
          .init(
            title: "제목 \(i)",
            summary: "요약 \(i)",
            blogName: "블로그",
            url: URL(string: "https://example.com/\(i)")!,
            thumbnailURL: nil,
            datetime: nil
          )
        }
        repo.pageInfo = .init(isEnd: false, totalCount: 5)
        let sut = DefaultSearchBlogsUseCase(repository: repo)

        async let r1 = sut("동시성", page: 1, size: 5)
        async let r2 = sut("동시성", page: 2, size: 5)
        async let r3 = sut("동시성", page: 3, size: 5)
        let results = try await [r1, r2, r3]
        let callCount = await repo.state.callCount
        XCTAssertEqual(callCount, 3)
        XCTAssertEqual(results.count, 3)
    }
}
