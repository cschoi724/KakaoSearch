//
//  AuthProvider.swift
//  Core
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public protocol AuthProvider {
    func authorizationHeaders(for endpoint: APIRequest) -> [String: String]
}
