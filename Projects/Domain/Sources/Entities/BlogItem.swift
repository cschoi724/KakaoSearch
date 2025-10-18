//
//  BlogItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct BlogItem: Equatable, Sendable {
    public let title: String
    public let contents: String
    public let blogName: String
    public let url: String
    public let thumbnail: String?
    public let datetime: String?

    public init(
        title: String,
        contents: String,
        blogName: String,
        url: String,
        thumbnail: String?,
        datetime: String?
    ) {
        self.title = title
        self.contents = contents
        self.blogName = blogName
        self.url = url
        self.thumbnail = thumbnail
        self.datetime = datetime
    }
}
