//
//  FeedItemType.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import Foundation

enum FeedItemType: String, Decodable {
  case materia, basico, other
  
  init(from decoder: Decoder) throws {
    let value = try decoder.singleValueContainer().decode(String.self)
    self = FeedItemType(rawValue: value) ?? .other
  }
  
  func isTypeAllowed() -> Bool {
    return [ .materia, .basico ].contains(self)
  }
}
