//
//  KakaoAPIError.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public enum KakaoAPIError: LocalizedError, Equatable {
    case platform(code: Int, message: String?)
    case unknown(statusCode: Int)

    public var errorDescription: String? {
        switch self {
        case let .platform(code, message):
            return message ?? "카카오 API 오류(code: \(code))"
        case let .unknown(statusCode):
            return "알 수 없는 오류 (HTTP \(statusCode))"
        }
    }
}
