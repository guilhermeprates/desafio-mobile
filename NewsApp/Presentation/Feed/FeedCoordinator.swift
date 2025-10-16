//
//  FeedCoordinator.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import UIKit

final class FeedCoordinator: FlowCoordinator {
 
  var children: [Coordinator] = []
  
  var navigation: UINavigationController
  
  var dependecies: FeedDIContainer
  
  init(navigation: UINavigationController, dependecies: FeedDIContainer) {
    self.dependecies = dependecies
    self.navigation = navigation
  }
  
  func start() {
    let feedRepository = DefaultFeedRepository(networkService: dependecies.networkService)
    let feedViewModel = FeedViewModel(product: dependecies.product, feedRepository: feedRepository)
    let feedViewController = FeedViewController(viewModel: feedViewModel)
    feedViewController.title = dependecies.title
    feedViewController.goToWebView = { [weak self] url in
      self?.goToWebView(url: url)
    }
    navigation.pushViewController(feedViewController, animated: false)
  }
  
  func goToWebView(url: URL) {
    let viewController = WebViewController(url: url)
    viewController.hidesBottomBarWhenPushed = true
    navigation.pushViewController(viewController, animated: true)
  }
}
