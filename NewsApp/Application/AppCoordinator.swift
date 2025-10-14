//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit

final class AppCoordinator: NSObject, TabBarCoordinator {
  
  private let container: AppDIContainer
  
  var tabBarController: UITabBarController
  
  var children: [Coordinator] = []
  
  init(tabBarController: UITabBarController, container: AppDIContainer) {
    self.tabBarController = tabBarController
    self.container = container
  }
  
  func start() {
    let g1FeedViewController = FeedViewController()
    g1FeedViewController.tabBarItem = UITabBarItem(
      title: "G1",
      image: UIImage(systemName: "newspaper"),
      tag: 0
    )
    
    let agronegocioFeedViewController = FeedViewController()
    agronegocioFeedViewController.tabBarItem = UITabBarItem(
      title: "Agronegócio",
      image: UIImage(systemName: "newspaper"),
      tag: 1
    )
    
    tabBarController.viewControllers = [
      g1FeedViewController,
      agronegocioFeedViewController
    ]
    
    tabBarController.selectedIndex = 0
  }
}

