//
//  FeedItemViewModel.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import SwiftUI
import Foundation
import Combine

final class FeedItemViewModel: ObservableObject {
  
  @Published
  private var item: FeedItem
  
  var title: String {
    return item.title
  }
  
  var summary: String {
    guard let summary = item.summary else { return "" }
    return summary
  }
  
  var metadata: String {
    return item.metadata
  }
  
  var image: URL? {
    return item.image
  }
  
  var chapeu: String {
    return item.chapeu
  }
  
  init(item: FeedItem) {
    self.item = item
  }
}
