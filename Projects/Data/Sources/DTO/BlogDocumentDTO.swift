//
//  BlogDocumentDTO.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain

public struct BlogDocumentDTO: Decodable {
    public let title: String
    public let contents: String
    public let url: String
    public let blogname: String
    public let thumbnail: String?
    public let datetime: String
}

public extension BlogDocumentDTO {
    func toDomain() -> BlogItem {
        BlogItem(
            title: title,
            contents: contents,
            blogName: blogname,
            url: url,
            thumbnail: thumbnail,
            datetime: datetime
        )
    }
}
