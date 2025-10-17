//
//  NetworkClientTests.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import XCTest
import Alamofire
@testable import Core

private struct TestAuthProvider: AuthProvider {
    let header: String
    func authorizationHeaders(for endpoint: APIRequest) -> [String: String] {
        ["Authorization": header]
    }
}

final class NetworkClientTests: XCTestCase {

    private func makeSession() -> Session {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return Session(configuration: config)
    }

    private func makeClient(authProviders: [AuthProvider] = [], logger: NetworkLogger? = nil) -> NetworkClient {
        DefaultNetworkClient(
            session: makeSession(),
            logger: logger,
            authProviders: authProviders
        )
    }

    // 200 OK + 유효 JSON → 성공 디코딩
    func test_success_decodesJSON() async throws {
        let expected = TestUser(id: 1, name: "blob")

        MockURLProtocol.requestHandler = { request in
            let data = try JSONEncoder().encode(expected)
            let url = request.url!
            let res = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (res, data)
        }

        let client = makeClient()
        let endpoint = TestEndpoint()
        let user: TestUser = try await client.request(endpoint, decoder: JSONDecoder())
        XCTAssertEqual(user, expected)
    }

    
    //401 등 비정상 상태 코드 → NetworkError.statusCode
    func test_throwsStatusCode() async {
        MockURLProtocol.requestHandler = { request in
            let data = Data("unauthorized".utf8)
            let res = HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (res, data)
        }

        let client = makeClient()
        let endpoint = TestEndpoint()

        do {
            _ = try await client.requestData(endpoint)
            XCTFail("Expected to throw")
        } catch let error as NetworkError {
            switch error {
            case .statusCode(let code, _):
                XCTAssertEqual(code, 401)
            default:
                XCTFail("Expected statusCode error")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // 200 OK + 잘못된 JSON → NetworkError.decoding
    func test_decodingFailure_throwsDecoding() async {
        MockURLProtocol.requestHandler = { request in
            // 잘못된 JSON (id를 문자열로 줌)
            let bad = #"{"id":"oops","name":"blob"}"#.data(using: .utf8)!
            let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (res, bad)
        }

        let client = makeClient()
        let endpoint = TestEndpoint()

        do {
            let _: TestUser = try await client.request(endpoint, decoder: JSONDecoder())
            XCTFail("Expected to throw decoding error")
        } catch let error as NetworkError {
            switch error {
            case .decoding:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected decoding error")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // AuthProvider가 Authorization 주입
    func test_authProvider_injectsAuthorization_whenEndpointHeaderAbsent() async throws {
        let exp = expectation(description: "Authorization header injected")

        MockURLProtocol.requestHandler = { request in
            let auth = request.value(forHTTPHeaderField: "Authorization")
            XCTAssertEqual(auth, "KakaoAK test_key")
            exp.fulfill()
            let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (res, Data("{}".utf8))
        }

        let client = makeClient(authProviders: [TestAuthProvider(header: "KakaoAK test_key")])
        let endpoint = TestEndpoint(headers: [:])
        _ = try await client.requestData(endpoint)

        await fulfillment(of: [exp], timeout: 1.0)
    }

    // 엔드포인트가 직접 설정한 헤더가 우선
    func test_endpointHeader_winsOverProvider() async throws {
        let exp = expectation(description: "Endpoint header overrides provider")

        MockURLProtocol.requestHandler = { request in
            let auth = request.value(forHTTPHeaderField: "Authorization")
            XCTAssertEqual(auth, "Custom ABC")
            exp.fulfill()
            let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (res, Data("{}".utf8))
        }

        let client = makeClient(authProviders: [TestAuthProvider(header: "Bearer SHOULD_NOT_OVERRIDE")])
        let endpoint = TestEndpoint(headers: ["Authorization": "Custom ABC"])
        _ = try await client.requestData(endpoint)

        await fulfillment(of: [exp], timeout: 1.0)
    }

    // 전송 오류(transport) → NetworkError.transport
    func test_transportError_bubblesUp() async {
        MockURLProtocol.requestHandler = { _ in
            throw URLError(.notConnectedToInternet)
        }

        let client = makeClient()
        let endpoint = TestEndpoint()

        do {
            _ = try await client.requestData(endpoint)
            XCTFail("Expected transport error")
        } catch let error as NetworkError {
            switch error {
            case .transport:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected transport error")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
