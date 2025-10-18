//
//  SearchVideosUseCaseTests.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Domain

final class SearchVideosUseCaseTests: XCTestCase {

    // 1) 성공 기본 흐름
    func test_success_returnsItemsAndPageInfo() async throws {
        let repo = VideoSearchRepositoryStub()
        repo.items = [
            .init(
                title: "테스트 비디오",
                url: "https://example.com/video1",
                datetime: "2025-10-18T00:00:00+09:00",
                playTime: 120,
                thumbnail: "https://example.com/thumb.png",
                author: "작가명"
            )
        ]
        repo.pageInfo = .init(isEnd: false, pageableCount: 10, totalCount: 42)
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let request = SearchRequest(query: "강아지", sort: "accuracy", page: 1, size: 10)
        let (items, page) = try await sut(request)

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.title, "테스트 비디오")
        XCTAssertFalse(page.isEnd)
        XCTAssertEqual(page.totalCount, 42)
        XCTAssertEqual(page.pageableCount, 10)
    }

    // 2) 빈 결과
    func test_empty_returnsEmptyAndEndTrue() async throws {
        let repo = VideoSearchRepositoryStub()
        repo.items = []
        repo.pageInfo = .init(isEnd: true, pageableCount: 0, totalCount: 0)
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let request = SearchRequest(query: "없는키워드", sort: "accuracy", page: 1, size: 10)
        let (items, page) = try await sut(request)

        XCTAssertTrue(items.isEmpty)
        XCTAssertTrue(page.isEnd)
        XCTAssertEqual(page.totalCount, 0)
    }

    // 3) 에러 전파
    func test_error_isPropagated() async {
        enum StubError: Error, Equatable { case boom }
        let repo = VideoSearchRepositoryStub()
        repo.error = StubError.boom
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let request = SearchRequest(query: "에러키워드", sort: "accuracy", page: 1, size: 10)
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
        let repo = VideoSearchRepositoryStub()
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let request = SearchRequest(query: "고양이", sort: "accuracy", page: 2, size: 30)
        _ = try await sut(request)

        let callCount = await repo.state.callCount
        let received = await repo.state.receivedRequests

        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(received.map { $0.query }, ["고양이"])
        XCTAssertEqual(received.map { $0.page }, [2])
        XCTAssertEqual(received.map { $0.size }, [30])
        XCTAssertEqual(received.map { $0.sort }, ["accuracy"])
    }

    // 5) 동시성
    func test_concurrentCalls_doNotCrash() async throws {
        let repo = VideoSearchRepositoryStub()
        repo.items = (0..<3).map { i in
            .init(
                title: "비디오 \(i)",
                url: "https://example.com/\(i)",
                datetime: nil,
                playTime: 100 + i,
                thumbnail: nil,
                author: "작가 \(i)"
            )
        }
        repo.pageInfo = .init(isEnd: false, pageableCount: 3, totalCount: 3)
        let sut = DefaultSearchVideosUseCase(repository: repo)

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
