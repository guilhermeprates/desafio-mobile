//
//  FeedViewModel.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import SwiftUI
import Foundation
import Combine

final class FeedViewModel {
  
  @Published
  private(set) var items: [FeedItem] = []
  
  @Published
  private(set) var isLoading = false
  
  @Published
  private(set) var errorMessage: String? = nil
  
  private var product: String
  
  private var oferta: String?
  
  private var pages: [FeedPage] = []
  
  private var fetchPageUseCase: FetchFeedUseCase
  
  private var fetchNextPageUseCase: FetchFeedNextPageUseCase
  
  private var cancellables = Set<AnyCancellable>()
  
  init(product: String, feedRepository: FeedRepository) {
    self.product = product
    self.fetchPageUseCase = FetchFeedUseCase(feedRepository: feedRepository)
    self.fetchNextPageUseCase = FetchFeedNextPageUseCase(feedRepository: feedRepository)
  }
  
  func loadFeed() {
    guard !isLoading else { return }
    
    isLoading = true
    fetchPageUseCase.start(product: product)
      .sink (
        receiveCompletion: { [weak self] completion in
          self?.isLoading = false
          if case .failure(let error) = completion {
            switch error {
              case .httpStatus(let code, _):
                if code != 404 {
                  self?.errorMessage = "Ops! Algo de errado aconteceu."
                }
                /// page not found, pagination end reached
              default:
                self?.errorMessage = "Ops! Algo de errado aconteceu."
            }
          }
        },
        receiveValue: { [weak self] feedPage in
          self?.pages.append(feedPage)
          self?.oferta = feedPage.oferta
          self?.items = feedPage.items
        }
      )
      .store(in: &cancellables)
  }
  
  func loadNextPage() {
    guard !isLoading else { return }
    
    guard let page = self.pages.last,
          let id = oferta else { return }
    
    let parameters = PageParameters(
      product: product,
      id: id,
      page: page.nextPage
    )
    
    fetchNextPageUseCase.start(parameters: parameters)
      .sink (
        receiveCompletion: { [weak self] completion in
          self?.isLoading = false
          if case .failure(let error) = completion {
            switch error {
              case .httpStatus(let code, _):
                if code != 404 {
                  self?.errorMessage = "Ops! Algo de errado aconteceu."
                }
                /// page not found, pagination end reached
              default:
                self?.errorMessage = "Ops! Algo de errado aconteceu."
            }
          }
        },
        receiveValue: { [weak self] feedPage in
          self?.pages.append(feedPage)
          self?.items.append(contentsOf: feedPage.items)
        }
      )
      .store(in: &cancellables)
  }
}
