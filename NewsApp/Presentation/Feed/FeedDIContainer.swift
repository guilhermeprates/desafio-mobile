//
//  FeedDIContainer.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import UIKit

final class FeedDIContainer {
  
  private(set) var product: String
  
  private(set) var title: String
  
  private(set) var networkService: NetworkService
  
  init(product: String, title: String, networkService: NetworkService) {
    self.product = product
    self.title = title
    self.networkService = networkService
  }
}
