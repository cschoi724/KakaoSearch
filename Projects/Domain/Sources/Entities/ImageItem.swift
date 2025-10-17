//
//  ImageItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//
import Foundation

public struct ImageItem: Equatable, Sendable, Identifiable {
  public var id: String { imageURL?.absoluteString ?? thumbnailURL?.absoluteString ?? UUID().uuidString }

  public let thumbnailURL: URL?
  public let imageURL: URL?
  public let displaySiteName: String?
  public let datetime: Date?

  public init(
    thumbnailURL: URL?,
    imageURL: URL?,
    displaySiteName: String?,
    datetime: Date?
  ) {
    self.thumbnailURL = thumbnailURL
    self.imageURL = imageURL
    self.displaySiteName = displaySiteName
    self.datetime = datetime
  }
}
