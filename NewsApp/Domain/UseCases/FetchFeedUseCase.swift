//
//  FetchFeedUseCase.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation
import Combine

final class FetchFeedUseCase {
  
  private let feedRepository: FeedRepository
  
  init(feedRepository: FeedRepository) {
    self.feedRepository = feedRepository
  }
  
  func getFeedPage(product: String) -> AnyPublisher<FeedPage, NetworkError> {
    return self.feedRepository.fetchFeedPage(product: product)
  }
}
