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
    tabBarController.viewControllers = [
      UINavigationController(
        rootViewController: container.makeFeed(
          title: "G1",
          product: "g1",
          tabBarImage: UIImage(systemName: "newspaper"),
          tabBarTag: 2
        )
      ),
      UINavigationController(
        rootViewController: container.makeFeed(
          title: "Agronegócio",
          product: "https://g1.globo.com/economia/agronegocios",
          tabBarImage: UIImage(systemName: "newspaper"),
          tabBarTag: 1
        )
      )
    ]
    tabBarController.selectedIndex = 0
  }
}

