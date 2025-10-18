//
//  VideoItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct VideoItem: Equatable, Sendable {
    public let title: String
    public let url: String
    public let datetime: String?
    public let playTime: Int
    public let thumbnail: String?
    public let author: String?

    public init(
        title: String,
        url: String,
        datetime: String?,
        playTime: Int,
        thumbnail: String?,
        author: String?
    ) {
        self.title = title
        self.url = url
        self.datetime = datetime
        self.playTime = playTime
        self.thumbnail = thumbnail
        self.author = author
    }
}
