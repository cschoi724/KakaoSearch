//
//  VideoDocumentDTO.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain

public struct VideoDocumentDTO: Decodable {
    public let title: String
    public let url: String
    public let datetime: String
    public let playTime: Int
    public let thumbnail: String
    public let author: String

    enum CodingKeys: String, CodingKey {
        case title
        case url
        case datetime
        case playTime = "play_time"
        case thumbnail
        case author
    }
}

public extension VideoDocumentDTO {
    func toDomain() -> VideoItem {
        VideoItem(
            title: title,
            url: url,
            datetime: datetime,
            playTime: playTime,
            thumbnail: thumbnail,
            author: author
        )
    }
}
