//
//  ImageRemoteDataSourceTests.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Data
@testable import Domain
@testable import Core

final class ImageRemoteDataSourceTests: XCTestCase {

    private var client: NetworkClientStub!
    private var sut: ImageRemoteDataSource!

    override func setUp() {
        super.setUp()
        client = NetworkClientStub()
        sut = ImageRemoteDataSourceImpl(client: client)
    }

    override func tearDown() {
        sut = nil
        client = nil
        super.tearDown()
    }

    // 1) 성공: 200 + 유효 JSON → DTO 디코딩 성공
    func test_success_decodesDTO() async throws {
        let json = """
        {
          "documents": [
            {
              "collection": "blog",
              "thumbnail_url": "https://img.ex.com/t.png",
              "image_url": "https://img.ex.com/original.png",
              "width": 800,
              "height": 600,
              "display_sitename": "annyeong",
              "doc_url": "https://blog.ex.com/post/1",
              "datetime": "2025-10-18T10:00:00.000+09:00"
            }
          ],
          "meta": { "total_count": 1, "pageable_count": 1, "is_end": true }
        }
        """.data(using: .utf8)!
        client.setNextResponse(status: 200, data: json)

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        let dto = try await sut.fetchImages(req)

        XCTAssertEqual(dto.documents.count, 1)
        XCTAssertEqual(dto.documents.first?.imageURL, "https://img.ex.com/original.png")
        XCTAssertEqual(dto.meta.totalCount, 1)
        XCTAssertEqual(dto.meta.pageableCount, 1)
        XCTAssertTrue(dto.meta.isEnd)
    }

    // 2) 요청 구성: 경로/쿼리 파라미터가 올바르게 반영되는가
    func test_request_buildsCorrectURLAndQuery() async throws {
        let dummyData = #"{"documents":[],"meta":{"total_count":0,"pageable_count":0,"is_end":true}}"#.data(using: .utf8)!
        client.setNextResponse(status: 200, data: dummyData)

        let request = SearchRequest(query: "ios", sort: "accuracy", page: 3, size: 15)
        _ = try await sut.fetchImages(request)

        guard let url = client.lastRequest?.url,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return XCTFail("URL 구성 실패")
        }

        XCTAssertEqual(components.path, "/v2/search/image", "요청 경로가 올바르지 않음")

        let queryDict = Dictionary(uniqueKeysWithValues: (components.queryItems ?? []).map { ($0.name, $0.value ?? "") })
        XCTAssertEqual(queryDict["query"], "ios")
        XCTAssertEqual(queryDict["sort"], "accuracy")
        XCTAssertEqual(queryDict["page"], "3")
        XCTAssertEqual(queryDict["size"], "15")
    }

    // 3) 카카오 플랫폼 오류 본문 → KakaoAPIError.platform 매핑
    func test_kakaoPlatformError_mapsToPlatform() async {
        let body = #"{ "code": -2, "msg": "bad request" }"#.data(using: .utf8)!
        client.setNextResponse(status: 400, data: body)

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        do {
            _ = try await sut.fetchImages(req)
            XCTFail("Should throw KakaoAPIError.platform")
        } catch let error as KakaoAPIError {
            switch error {
            case let .platform(code, message):
                XCTAssertEqual(code, -2)
                XCTAssertEqual(message, "bad request")
            case .unknown:
                XCTFail("Expected .platform, got .unknown")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // 4) 비-카카오 본문 + 4xx → NetworkError.statusCode 유지
    func test_nonKakaoBody_keepsNetworkStatusCode() async {
        client.setNextResponse(status: 404, data: #"{"oops":"not kakao"}"#.data(using: .utf8))

        let req = SearchRequest(query: "swift", sort: "accuracy", page: 1, size: 10)
        do {
            _ = try await sut.fetchImages(req)
            XCTFail("Should throw")
        } catch let error as NetworkError {
            guard case let .statusCode(status, body) = error else {
                return XCTFail("Expected .statusCode")
            }
            XCTAssertEqual(status, 404)
            XCTAssertNotNil(body)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
