//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit

final class AppDIContainer {
  
  var appConfiguration = AppConfiguration()
  
  lazy var networkService: NetworkService = {
    do {
      let baseURL = try appConfiguration.apiBaseURL
      let configuration = DefaultNetworkConfig(baseURL: baseURL)
      return NetworkService(configuration: configuration)
    } catch {
      fatalError("Could not create NetworkService: \(error)")
    }
  }()
  
  func makeFeed(
    title: String,
    product: String,
    tabBarImage image: UIImage? = nil,
    tabBarTag tag: Int = 0
  ) -> FeedViewController {
    let feedRepository = DefaultFeedRepository(networkService: networkService)
    let feedViewModel = FeedViewModel(product: product, feedRepository: feedRepository)
    let feedViewController = FeedViewController(viewModel: feedViewModel)
    feedViewController.title = title
    feedViewController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
    return feedViewController
  }
}
