//
//  FeedPage.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation

final class FeedPage {
  let items: FeedItems
  let nextPage: Int
  let oferta: String
  
  init(items: FeedItems, nextPage: Int, oferta: String) {
    self.items = items
    self.nextPage = nextPage
    self.oferta = oferta
  }
}


