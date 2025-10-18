//
//  SearchResponseDTO.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct SearchResponseDTO<T: Decodable>: Decodable {
    public let documents: [T]
    public let meta: MetaDTO
}
