//
//  FeedResponseDTO+Mapping.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation

struct ResponseDTO: Decodable {
  var feed: FeedPageDTO
}

struct FeedPageDTO: Decodable {
  struct Falkor: Decodable {
    var items: [FeedItemDTO]
    var nextPage: Int
  }
  
  var oferta: String
  var falkor: Falkor
}

extension FeedPageDTO {
  
  func toDomain() -> FeedPage {
    return FeedPage(
      items: self.falkor.items.map { $0.toDomain() },
      nextPage: self.falkor.nextPage,
      oferta: self.oferta
    )
  }
}

struct FeedItemDTO: Decodable {
  struct Content: Decodable {
    var title: String?
    var summary: String?
    var chapeu: Chapeu?
    var image: Image?
  }

  struct Chapeu: Decodable {
    var label: String
  }
  
  struct Image: Decodable {
    var url: String
  }
  
  var type: String?
  var content: Content?
  var metadata: String?
}

extension FeedItemDTO {
  
  func toDomain() -> FeedItem {
    return FeedItem(
      type: self.type ?? "",
      title: self.content?.title ?? "",
      summary: self.content?.summary ?? "",
      chapeu: self.content?.chapeu?.label ?? "",
      image: URL(string: self.content?.image?.url ?? ""),
      metadata: self.metadata ?? "")
  }
}
