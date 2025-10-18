//
//  ImageDocumentDTO.swift
//  Data
//
//  Created by 일하는석찬 on 10/18/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation
import Domain

public struct ImageDocumentDTO: Decodable {
    public let collection: String
    public let thumbnailURL: String
    public let imageURL: String
    public let width: Int
    public let height: Int
    public let displaySiteName: String
    public let docURL: String
    public let datetime: String

    enum CodingKeys: String, CodingKey {
        case collection
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
        case width
        case height
        case displaySiteName = "display_sitename"
        case docURL = "doc_url"
        case datetime
    }
}

public extension ImageDocumentDTO {
    func toDomain() -> ImageItem {
        ImageItem(
            collection: collection,
            thumbnailUrl: thumbnailURL,
            imageUrl: imageURL,
            width: width,
            height: height,
            displaySiteName: displaySiteName,
            docUrl: docURL,
            datetime: datetime
        )
    }
}
