//
//  FeedRepository.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation
import Combine

protocol FeedRepository {
  @discardableResult
  func fetchFeedPage(product: String) -> AnyPublisher<FeedPage, NetworkError>

  @discardableResult
  func fetchFeedNextPage(parameters: PageParameters) -> AnyPublisher<FeedPage, NetworkError>
}
