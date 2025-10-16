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
  var oferta: String?
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
    struct Chapeu: Decodable {
      var label: String
    }
    var title: String?
    var summary: String?
    var chapeu: Chapeu?
    var image: Image?
    var url: String?
  }

  struct Image: Codable {
    struct Sizes: Codable {
      struct Size: Codable {
        let height: Int
        let url: String
        let width: Int
      }
      let L: Size
      let M: Size
      let Q: Size
      let S: Size
      let V: Size
      let VL: Size
      let VM: Size
      let VS: Size
      let VXL: Size
      let VXS: Size
      let XS: Size
    }
    let sizes: Sizes
    let url: String
  }
  var id: String
  var type: String?
  var content: Content?
  var metadata: String?
}

extension FeedItemDTO {
  func toDomain() -> FeedItem {
    return FeedItem(
      id: self.id,
      type: FeedItemType(rawValue: self.type ?? "") ?? .other,
      title: self.content?.title ?? "",
      summary: self.content?.summary ?? "",
      chapeu: self.content?.chapeu?.label ?? "",
      image: URL(string: self.content?.image?.sizes.M.url ?? ""),
      metadata: self.metadata ?? "",
      url: URL(string: self.content?.url ?? "")
    )
  }
}
