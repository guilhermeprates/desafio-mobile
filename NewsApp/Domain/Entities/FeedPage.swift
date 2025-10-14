//
//  FeedPage.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation

final class FeedPage {
  var items: FeedItems
  var nextPage: Int
  var oferta: String
  
  init(items: FeedItems, nextPage: Int, oferta: String) {
    self.items = items
    self.nextPage = nextPage
    self.oferta = oferta
  }
}

typealias FeedItems = [FeedItem]

final class FeedItem {
  var type: String
  var title: String
  var summary: String?
  var chapeu: String
  var image: URL?
  var metadata: String
  
  init(type: String, title: String, summary: String? = nil, chapeu: String, image: URL? = nil, metadata: String) {
    self.type = type
    self.title = title
    self.summary = summary
    self.chapeu = chapeu
    self.image = image
    self.metadata = metadata
  }
}
