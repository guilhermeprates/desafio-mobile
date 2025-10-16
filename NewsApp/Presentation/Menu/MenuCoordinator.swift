//
//  MenuCoordinator.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import UIKit

final class MenuCoordinator: FlowCoordinator {
  
  var children: [Coordinator] = []
  
  var navigation: UINavigationController
  
  var dependecies: MenuDIContainer
  
  init(navigation: UINavigationController, dependecies: MenuDIContainer) {
    self.dependecies = dependecies
    self.navigation = navigation
  }
  
  func start() {
    let menuRepository = DefaultMenuRepository(fileReaderService: dependecies.fileReaderService)
    let menuViewController = MenuViewController(repository: menuRepository)
    menuViewController.goToWebView = { [weak self] url in
      self?.goToWebView(url: url)
    }
    navigation.pushViewController(menuViewController, animated: false)
  }
  
  func goToWebView(url: URL) {
    let viewController = WebViewController(url: url)
    viewController.hidesBottomBarWhenPushed = true
    navigation.pushViewController(viewController, animated: true)
  }
}
