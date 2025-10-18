//
//  KakaoAPIEndpointTests.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Data
@testable import Domain

final class KakaoAPIEndpointTests: XCTestCase {

    // 1) 블로그 검색
    func test_searchBlog_buildsCorrectPathAndQuery_withDefaultSort() {
        let req = SearchRequest(query: "swift", sort: "accuracy", page: 2, size: 10)
        let sut = KakaoAPIEndpoint.blog(req)

        XCTAssertEqual(sut.path, "/v2/search/blog")
        let qp = sut.queryParameters
        XCTAssertEqual(qp?["query"] as? String, "swift")
        XCTAssertEqual(qp?["page"] as? Int, 2)
        XCTAssertEqual(qp?["size"] as? Int, 10)
        XCTAssertEqual(qp?["sort"] as? String, "accuracy")
    }

    // 2) 이미지 검색
    func test_searchImage_buildsCorrectPathAndQuery_withExplicitSort() {
        let req = SearchRequest(query: "cat", sort: "recency", page: 1, size: 5)
        let sut = KakaoAPIEndpoint.image(req)

        XCTAssertEqual(sut.path, "/v2/search/image")
        let qp = sut.queryParameters
        XCTAssertEqual(qp?["query"] as? String, "cat")
        XCTAssertEqual(qp?["page"] as? Int, 1)
        XCTAssertEqual(qp?["size"] as? Int, 5)
        XCTAssertEqual(qp?["sort"] as? String, "recency")
    }

    // 3) 비디오 검색
    func test_searchVideo_buildsCorrectPath_withDefaultSort() {
        let req = SearchRequest(query: "tca", sort: "accuracy", page: 1, size: 5)
        let sut = KakaoAPIEndpoint.video(req)

        XCTAssertEqual(sut.path, "/v2/search/vclip")
        let qp = sut.queryParameters
        XCTAssertEqual(qp?["query"] as? String, "tca")
        XCTAssertEqual(qp?["page"] as? Int, 1)
        XCTAssertEqual(qp?["size"] as? Int, 5)
        XCTAssertEqual(qp?["sort"] as? String, "accuracy")
    }
}
