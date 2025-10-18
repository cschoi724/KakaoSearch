//
//  ImageItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct ImageItem: Equatable, Sendable {
    public let collection: String
    public let thumbnailUrl: String
    public let imageUrl: String
    public let width: Int
    public let height: Int
    public let displaySiteName: String?
    public let docUrl: String?
    public let datetime: String?

    public init(
        collection: String,
        thumbnailUrl: String,
        imageUrl: String,
        width: Int,
        height: Int,
        displaySiteName: String?,
        docUrl: String?,
        datetime: String?
    ) {
        self.collection = collection
        self.thumbnailUrl = thumbnailUrl
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
        self.displaySiteName = displaySiteName
        self.docUrl = docUrl
        self.datetime = datetime
    }
}
