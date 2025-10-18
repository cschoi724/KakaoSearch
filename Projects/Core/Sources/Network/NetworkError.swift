//
//  NetworkError.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case invalidURL
    case transport(Error)              // URLSession 에러 래핑
    case statusCode(Int, Data?)        // HTTP 상태 코드 에러
    case decoding(Error, Data?)        // Decoding 실패

    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL): return true
        case let (.statusCode(a, _), .statusCode(b, _)): return a == b
        case (.transport, .transport): return true
        case (.decoding, .decoding): return true
        default: return false
        }
    }
}
