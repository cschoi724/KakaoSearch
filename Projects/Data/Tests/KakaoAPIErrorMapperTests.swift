//
//  KakaoAPIErrorMapperTests.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
@testable import Data
@testable import Core

final class KakaoAPIErrorMapperTests: XCTestCase {

    // 1) 카카오 에러 바디 포함 statusCode → KakaoAPIError.platform 으로 매핑
    func test_map_statusCodeWithKakaoBody_returnsPlatformError() throws {
        let body = #"{"code":-2,"msg":"invalid param"}"#.data(using: .utf8)!
        let input = NetworkError.statusCode(400, body)
        let mapped = KakaoAPIErrorMapper.map(input)

        guard let kakao = mapped as? KakaoAPIError else {
            return XCTFail("expected KakaoAPIError but got \(type(of: mapped))")
        }
        switch kakao {
        case let .platform(code, message):
            XCTAssertEqual(code, -2)
            XCTAssertEqual(message, "invalid param")
        default:
            XCTFail("expected KakaoAPIError.platform but got \(kakao)")
        }
    }

    // 2) 카카오 형식이 아닌 바디 → NetworkError.statusCode 그대로 유지
    func test_map_statusCodeWithNonKakaoBody_keepsOriginalNetworkError() {
        let body = #"{"error":"bad_request"}"#.data(using: .utf8)!
        let input = NetworkError.statusCode(400, body)
        let mapped = KakaoAPIErrorMapper.map(input)

        guard case let .statusCode(code, data?) = (mapped as? NetworkError) else {
            return XCTFail("expected NetworkError.statusCode passthrough but got \(type(of: mapped))")
        }
        XCTAssertEqual(code, 400)
        XCTAssertFalse(data.isEmpty)
    }

    // 3) transport 계열 오류는 그대로 전파
    func test_map_transport_passthrough() {
        let nsErr = NSError(domain: NSURLErrorDomain, code: -1009)
        let input = NetworkError.transport(nsErr)

        let mapped = KakaoAPIErrorMapper.map(input)

        guard case .transport = (mapped as? NetworkError) else {
            return XCTFail("expected NetworkError.transport passthrough but got \(type(of: mapped))")
        }
    }

    // 4) statusCode 이지만 바디가 nil → 카카오 매핑 불가, 원본 statusCode 유지
    func test_map_statusCodeWithoutBody_keepsOriginalNetworkError() {
        let input = NetworkError.statusCode(401, nil)
        let mapped = KakaoAPIErrorMapper.map(input)

        guard case let .statusCode(code, body) = (mapped as? NetworkError) else {
            return XCTFail("expected NetworkError.statusCode passthrough but got \(type(of: mapped))")
        }
        XCTAssertEqual(code, 401)
        XCTAssertNil(body)
    }

    // 5) 카카오 JSON이지만 필수 키 누락 → 카카오 매핑 불가, 원본 statusCode 유지
    func test_map_statusCodeWithMalformedKakaoBody_keepsOriginalNetworkError() {
        let body = #"{"code":-2}"#.data(using: .utf8)!
        let input = NetworkError.statusCode(400, body)
        let mapped = KakaoAPIErrorMapper.map(input)

        guard case let .statusCode(code, data?) = (mapped as? NetworkError) else {
            return XCTFail("expected NetworkError.statusCode passthrough but got \(type(of: mapped))")
        }
        XCTAssertEqual(code, 400)
        XCTAssertFalse(data.isEmpty)
    }
}
