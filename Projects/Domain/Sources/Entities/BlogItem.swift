//
//  BlogItem.swift
//  Domain
//
//  Created by 일하는석찬 on 10/17/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//
import Foundation

public struct BlogItem: Equatable, Sendable, Identifiable {
  public var id: String { url?.absoluteString ?? title }

  public let title: String
  public let summary: String?
  public let blogName: String?
  public let url: URL?
  public let thumbnailURL: URL?
  public let datetime: Date?

  public init(
    title: String,
    summary: String? = nil,
    blogName: String? = nil,
    url: URL?,
    thumbnailURL: URL? = nil,
    datetime: Date? = nil
  ) {
    self.title = title
    self.summary = summary
    self.blogName = blogName
    self.url = url
    self.thumbnailURL = thumbnailURL
    self.datetime = datetime
  }
}
