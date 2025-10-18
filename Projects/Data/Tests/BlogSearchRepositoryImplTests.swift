//
//  BlogSearchRepositoryImplTests.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Data
@testable import Domain
@testable import Core

final class BlogSearchRepositoryImplTests: XCTestCase {

    private var remote: BlogRemoteDataSourceStub!
    private var sut: BlogSearchRepositoryImpl!

    override func setUp() {
        super.setUp()
        remote = BlogRemoteDataSourceStub()
        sut = BlogSearchRepositoryImpl(remote: remote)
    }

    override func tearDown() {
        sut = nil
        remote = nil
        super.tearDown()
    }

    // 1) 성공: 정상 JSON -> 도메인 매핑
    func test_success_returnsMappedDomain() async throws {
        remote.nextDTO = SearchResponseDTO<BlogDocumentDTO>(
            documents: [
                BlogDocumentDTO(
                    title: "Swift 블로그",
                    contents: "내용",
                    url: "https://ex.com/1",
                    blogname: "annyeong",
                    thumbnail: "https://ex.com/t.png",
                    datetime: "2025-10-18T10:00:00.000+09:00"
                )
            ],
            meta: MetaDTO(totalCount: 1, pageableCount: 1, isEnd: true)
        )

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        let result = try await sut.searchBlogs(req)

        // then
        XCTAssertEqual(result.0.count, 1)
        XCTAssertEqual(result.0.first?.url, "https://ex.com/1")
        XCTAssertTrue(result.1.isEnd)
        XCTAssertEqual(result.1.totalCount, 1)
        XCTAssertEqual(result.1.pageableCount, 1)
    }

    // 2) 빈 문서: documents=[] -> 빈 결과
    func test_emptyDocuments_returnsEmptyList() async throws {
        remote.nextDTO = SearchResponseDTO<BlogDocumentDTO>(
            documents: [],
            meta: MetaDTO(totalCount: 0, pageableCount: 0, isEnd: true)
        )

        let req = SearchRequest(query: "none", sort: "accuracy", page: 1, size: 10)
        let result = try await sut.searchBlogs(req)

        XCTAssertTrue(result.0.isEmpty)
        XCTAssertEqual(result.1.totalCount, 0)
        XCTAssertEqual(result.1.pageableCount, 0)
    }

    // 3) 네트워크 오류: NetworkError 그대로 전파
    func test_networkError_isPropagated() async {
        remote.nextError = NetworkError.transport(URLError(.notConnectedToInternet))

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        do {
            _ = try await sut.searchBlogs(req)
            XCTFail("Should throw")
        } catch let error as NetworkError {
            if case .transport = error { /* OK */ } else {
                XCTFail("Expected transport")
            }
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // 4) 카카오 플랫폼 오류: 본문(code/msg) 매핑 -> KakaoAPIError.platform
    func test_kakaoPlatformError_isMappedToKakaoAPIError() async {
        remote.nextError = KakaoAPIError.platform(code: -2, message: "bad request")

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        do {
            _ = try await sut.searchBlogs(req)
            XCTFail("Should throw")
        } catch let error as KakaoAPIError {
            guard case let .platform(code, message) = error else {
                return XCTFail("Expected .platform")
            }
            XCTAssertEqual(code, -2)
            XCTAssertEqual(message, "bad request")
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}
