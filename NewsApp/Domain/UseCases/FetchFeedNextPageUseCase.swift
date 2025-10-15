//
//  FetchFeedNextPageUseCase.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import Foundation
import Combine

final class FetchFeedNextPageUseCase {
  
  private let feedRepository: FeedRepository
  
  init(feedRepository: FeedRepository) {
    self.feedRepository = feedRepository
  }
  
  func start(parameters: PageParameters) -> AnyPublisher<FeedPage, NetworkError> {
    return feedRepository.fetchFeedNextPage(parameters: parameters)
      .map {
        return FeedPage(
          items: $0.items.filter { self.isTypeAllowed($0.type) },
          nextPage: $0.nextPage,
          oferta: $0.oferta
        )
      }
      .eraseToAnyPublisher()
  }
  
  func isTypeAllowed(_ type: String) -> Bool {
    return type == "basico" || type == "materia"
  }
}

struct PageParameters {
  let product: String
  let id: String
  let page: Int
}
