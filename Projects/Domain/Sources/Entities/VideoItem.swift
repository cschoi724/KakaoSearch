//
//  VideoItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import Foundation

public struct VideoItem: Equatable, Sendable, Identifiable {
  public var id: String { url?.absoluteString ?? title }

  public let title: String
  public let author: String?
  public let playTimeSeconds: Int?
  public let url: URL?
  public let thumbnailURL: URL?
  public let datetime: Date?

  public init(
    title: String,
    author: String? = nil,
    playTimeSeconds: Int? = nil,
    url: URL?,
    thumbnailURL: URL? = nil,
    datetime: Date? = nil
  ) {
    self.title = title
    self.author = author
    self.playTimeSeconds = playTimeSeconds
    self.url = url
    self.thumbnailURL = thumbnailURL
    self.datetime = datetime
  }
}
