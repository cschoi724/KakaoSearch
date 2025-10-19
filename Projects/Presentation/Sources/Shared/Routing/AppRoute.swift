//
//  AppRoute.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public enum AppRoute: Hashable, Sendable {
    case imageDetail(id: String, imageURL: String?)
    case webExternal(url: String)
}
