//
//  NetworkClient.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: APIRequest, decoder: JSONDecoder) async throws -> T
    func requestData(_ endpoint: APIRequest) async throws -> Data
}

public final class DefaultNetworkClient: NetworkClient {
    private let session: Session
    private let logger: NetworkLogger?
    private let authProviders: [AuthProvider]

    public init(
        session: Session = .default,
        logger: NetworkLogger? = nil,
        authProviders: [AuthProvider] = []
    ) {
        self.session = session
        self.logger = logger
        self.authProviders = authProviders
    }

    public func request<T: Decodable>(_ endpoint: APIRequest, decoder: JSONDecoder) async throws -> T {
        let data = try await requestData(endpoint)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error, data)
        }
    }

    public func requestData(_ endpoint: APIRequest) async throws -> Data {
        var urlRequest = try endpoint.buildURLRequest()

        // endpoint.headers에 같은 키가 있으면 보존, 없을 때만 provider가 주입
        for provider in authProviders {
            let headers = provider.authorizationHeaders(for: endpoint)
            for (key, value) in headers where urlRequest.value(forHTTPHeaderField: key) == nil {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        logger?.willSend(urlRequest)

        let task = session.request(urlRequest).serializingData()
        let response = await task.response

        switch await task.result {
        case .success(let data):
            if let http = response.response, !(200..<300).contains(http.statusCode) {
                logger?.didFail(NetworkError.statusCode(http.statusCode, data), response: http)
                throw NetworkError.statusCode(http.statusCode, data)
            }
            if let http = response.response {
                logger?.didReceive(data, response: http)
            }
            return data

        case .failure(let afError):
            let http = response.response
            if let status = afError.responseCode {
                logger?.didFail(NetworkError.statusCode(status, nil), response: http)
                throw NetworkError.statusCode(status, nil)
            }
            logger?.didFail(afError, response: http)
            throw NetworkError.transport(afError)
        }
    }
}
