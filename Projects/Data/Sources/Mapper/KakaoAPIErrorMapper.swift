//
//  KakaoAPIErrorMapper.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Core

enum KakaoAPIErrorMapper {
    static func map(_ error: Error) -> Error {
        guard let net = error as? NetworkError else { return error }

        switch net {
        case let .statusCode(_, data):
            if let data, let body = try? JSONDecoder().decode(KakaoAPIErrorResponse.self, from: data) {
                return KakaoAPIError.platform(code: body.code, message: body.msg)
            }
            return net
        default:
            return net
        }
    }
}
