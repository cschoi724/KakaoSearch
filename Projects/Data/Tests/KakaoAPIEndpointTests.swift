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
        let expectedItems = [
            URLQueryItem(name: "query", value: "swift"),
            URLQueryItem(name: "page", value: "2"),
            URLQueryItem(name: "size", value: "10"),
            URLQueryItem(name: "sort", value: "accuracy")
        ]

        XCTAssertEqual(Set(sut.queryItems), Set(expectedItems))
    }

    // 2) 이미지 검색
    func test_searchImage_buildsCorrectPathAndQuery_withExplicitSort() {
        let req = SearchRequest(query: "cat", sort: "recency", page: 1, size: 5)
        let sut = KakaoAPIEndpoint.image(req)

        XCTAssertEqual(sut.path, "/v2/search/image")
        let expectedItems = [
            URLQueryItem(name: "query", value: "cat"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "size", value: "5"),
            URLQueryItem(name: "sort", value: "recency")
        ]
        XCTAssertEqual(Set(sut.queryItems), Set(expectedItems))
    }

    // 3) 비디오 검색
    func test_searchVideo_buildsCorrectPath_withDefaultSort() {
        let req = SearchRequest(query: "tca", sort: "accuracy", page: 1, size: 5)
        let sut = KakaoAPIEndpoint.video(req)

        XCTAssertEqual(sut.path, "/v2/search/vclip")
        let expectedItems = [
            URLQueryItem(name: "query", value: "tca"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "size", value: "5"),
            URLQueryItem(name: "sort", value: "accuracy")
        ]
        XCTAssertEqual(Set(sut.queryItems), Set(expectedItems))
    }
}
