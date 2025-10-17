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
            author: "작가명",
            playTimeSeconds: 120,
            url: URL(string: "https://example.com/video1")!,
            thumbnailURL: URL(string: "https://example.com/thumb.png"),
            datetime: Date()
          )
        ]
        repo.pageInfo = .init(isEnd: false, totalCount: 42)
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let (items, page) = try await sut("강아지", page: 1, size: 10)

        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.title, "테스트 비디오")
        XCTAssertFalse(page.isEnd)
        XCTAssertEqual(page.totalCount, 42)
    }

    // 2) 빈 결과
    func test_empty_returnsEmptyAndEndTrue() async throws {
        let repo = VideoSearchRepositoryStub()
        repo.items = []
        repo.pageInfo = .init(isEnd: true, totalCount: 0)
        let sut = DefaultSearchVideosUseCase(repository: repo)

        let (items, page) = try await sut("없는키워드", page: 1, size: 10)

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
        let repo = VideoSearchRepositoryStub()
        let sut = DefaultSearchVideosUseCase(repository: repo)

        _ = try await sut("고양이", page: 2, size: 30)

        let callCount = await repo.state.callCount
        let queries = await repo.state.receivedQueries
        let pages = await repo.state.receivedPages
        let sizes = await repo.state.receivedSizes

        XCTAssertEqual(callCount, 1)
        XCTAssertEqual(queries, ["고양이"])
        XCTAssertEqual(pages, [2])
        XCTAssertEqual(sizes, [30])
    }

    // 5) 동시성
    func test_concurrentCalls_doNotCrash() async throws {
        let repo = VideoSearchRepositoryStub()
        repo.items = (0..<3).map { i in
          .init(
            title: "비디오 \(i)",
            author: "작가 \(i)",
            playTimeSeconds: 100 + i,
            url: URL(string: "https://example.com/\(i)")!,
            thumbnailURL: nil,
            datetime: nil
          )
        }
        repo.pageInfo = .init(isEnd: false, totalCount: 3)
        let sut = DefaultSearchVideosUseCase(repository: repo)

        async let r1 = sut("동시성", page: 1, size: 5)
        async let r2 = sut("동시성", page: 2, size: 5)
        async let r3 = sut("동시성", page: 3, size: 5)
        let results = try await [r1, r2, r3]
        let callCount = await repo.state.callCount
        XCTAssertEqual(callCount, 3)
        XCTAssertEqual(results.count, 3)

    }
}
