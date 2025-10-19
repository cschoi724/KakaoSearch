//
//  KakaoAPIErrorResponse.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

struct KakaoAPIErrorResponse: Decodable {
    let code: Int
    let msg: String
}
