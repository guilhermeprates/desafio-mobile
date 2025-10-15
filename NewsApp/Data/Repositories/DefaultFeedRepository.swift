//
//  DefaultFeedRepository.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation
import Combine

final class DefaultFeedRepository: FeedRepository {
  
  private var networkService: NetworkService
  
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  func fetchFeedPage(product: String) -> AnyPublisher<FeedPage, NetworkError> {
    let endpoint = APIEndpoints.getFeedPage(product: product)
    return networkService.request(endpoint)
      .map { (dto: ResponseDTO) in dto.feed.toDomain() }
      .handleEvents(receiveOutput: { [weak self] feedPage in
          // TODO: handle persistence
      })
      .eraseToAnyPublisher()
  }
  
  func fetchFeedNextPage(parameters: PageParameters) -> AnyPublisher<FeedPage, NetworkError> {
    let endpoint = APIEndpoints.getFeedPage(parameters: parameters)
    return networkService.request(endpoint)
      .map { (dto: ResponseDTO) in dto.feed.toDomain() }
      .handleEvents(receiveOutput: { [weak self] feedPage in
        // TODO: handle persistence
      })
      .eraseToAnyPublisher()
  }
}
