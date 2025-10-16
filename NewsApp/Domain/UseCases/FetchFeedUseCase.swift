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
  
  func start(product: String) -> AnyPublisher<FeedPage, NetworkError> {
    return feedRepository.fetchFeedPage(product: product)
      .map {
        return FeedPage(
          items: $0.items.filter { $0.type.isTypeAllowed() },
          nextPage: $0.nextPage,
          oferta: $0.oferta
        )
      }
      .eraseToAnyPublisher()
  }
}
