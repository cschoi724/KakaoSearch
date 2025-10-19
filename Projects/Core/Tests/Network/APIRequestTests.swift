//
//  APIRequestTests.swift
//  Core
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Core

final class APIRequestTests: XCTestCase {

    // 경로와 쿼리 파라미터가 올바르게 조합되는가
    func test_buildURLRequest_appendsPathAndQuery() throws {
        let req = DummyReq(query: [
            URLQueryItem(name: "query", value: "ios"),
            URLQueryItem(name: "page", value: "3"),
            URLQueryItem(name: "size", value: "15"),
            URLQueryItem(name: "sort", value: "accuracy")
        ])

        let urlRequest = try req.buildURLRequest()

        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "dapi.kakao.com")
        XCTAssertEqual(urlRequest.url?.path, "/v2/search/blog")

        let comps = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false)
        let qs = comps?.queryItems ?? []
        let dict = Dictionary(uniqueKeysWithValues: qs.map { ($0.name, $0.value ?? "") })

        XCTAssertEqual(dict["query"], "ios")
        XCTAssertEqual(dict["page"], "3")
        XCTAssertEqual(dict["size"], "15")
        XCTAssertEqual(dict["sort"], "accuracy")
    }

    // 선행 슬래시가 있든 없든 동일한 경로로 빌드되는가
    func test_buildURLRequest_trimsLeadingSlashInPath() throws {
        let withSlash = DummyReq(path: "/v2/search/blog")
        let withoutSlash = DummyReq(path: "v2/search/blog")

        let r1 = try withSlash.buildURLRequest()
        let r2 = try withoutSlash.buildURLRequest()

        XCTAssertEqual(r1.url?.path, "/v2/search/blog")
        XCTAssertEqual(r2.url?.path, "/v2/search/blog")
    }

    // 헤더와 바디가 올바르게 적용되는가
    func test_buildURLRequest_appliesHeadersAndBody() throws {
        let body = Data("{\"k\":\"v\"}".utf8)
        let req = DummyReq(
            headers: ["X-Foo": "Bar"],
            body: body
        )

        let urlRequest = try req.buildURLRequest()

        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "X-Foo"), "Bar")
        XCTAssertEqual(urlRequest.httpBody, body)
    }
}
