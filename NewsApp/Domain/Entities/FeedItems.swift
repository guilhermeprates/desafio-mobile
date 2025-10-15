//
//  FeedItems.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import Foundation

typealias FeedItems = [FeedItem]

nonisolated final class FeedItem: Identifiable, Hashable {
  let id: UUID
  let type: String
  let title: String
  let summary: String?
  let chapeu: String
  let image: URL?
  let metadata: String
  let url: URL?
  
  init(
    type: String,
    title: String,
    summary: String? = nil,
    chapeu: String,
    image: URL? = nil,
    metadata: String,
    url: URL? = nil
  ) {
    self.id = UUID()
    self.type = type
    self.title = title
    self.summary = summary
    self.chapeu = chapeu
    self.image = image
    self.metadata = metadata
    self.url = url
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
    return lhs.id == rhs.id
  }
}
