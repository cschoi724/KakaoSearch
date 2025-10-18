//
//  KakaoAPIEndpoint.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain
import Core

public enum KakaoSort: String {
    case accuracy
    case recency
}

public enum KakaoAPIEndpoint {
    case searchBlog(query: String, page: Int, size: Int, sort: String)
    case searchImage(query: String, page: Int, size: Int, sort: String)
    case searchVideo(query: String, page: Int, size: Int, sort: String)
}

public extension KakaoAPIEndpoint {
    static func blog(_ request: SearchRequest) -> Self {
        .searchBlog(query: request.query, page: request.page, size: request.size, sort: request.sort)
    }

    static func image(_ request: SearchRequest) -> Self {
        .searchImage(query: request.query, page: request.page, size: request.size, sort: request.sort)
    }

    static func video(_ request: SearchRequest) -> Self {
        .searchVideo(query: request.query, page: request.page, size: request.size, sort: request.sort)
    }
}

extension KakaoAPIEndpoint: APIRequest {

    public var baseURL: URL {
        URL(string: "https://dapi.kakao.com")!
    }

    public var path: String {
        switch self {
        case .searchBlog:
            return "/v2/search/blog"
        case .searchImage:
            return "/v2/search/image"
        case .searchVideo:
            return "/v2/search/vclip"
        }
    }

    public var method: HTTPMethod {
        return .get
    }

    public var headers: [String : String] {
        [
            "Content-Type": "application/json"
        ]
    }

    public var queryParameters: [String : Any]? {
        switch self {
        case let .searchBlog(query, page, size, sort),
             let .searchImage(query, page, size, sort),
             let .searchVideo(query, page, size, sort):
            return [
                "query": query,
                "page": page,
                "size": size,
                "sort": sort
            ]
        }
    }

    public var body: Data? {
        return nil
    }

    public typealias Response = Decodable
}
