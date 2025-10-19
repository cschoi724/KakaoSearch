//
//  DummyReq.swift
//  Core
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
@testable import Core

struct DummyReq: APIRequest {
    let baseURL: URL = URL(string: "https://dapi.kakao.com")!
    let path: String
    let method: HTTPMethod
    let headers: [String: String]
    let queryItems: [URLQueryItem]
    let body: Data?

    init(
        path: String = "/v2/search/blog",
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        query: [URLQueryItem] = [],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = query
        self.body = body
    }
}
