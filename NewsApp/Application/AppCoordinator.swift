//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit

final class AppCoordinator: NSObject, TabBarCoordinator {
 
  var children: [Coordinator] = []
  
  var tabBarController: UITabBarController
  
  var dependecies: AppDIContainer
  
  init(tabBarController: UITabBarController, dependecies: AppDIContainer) {
    self.tabBarController = tabBarController
    self.dependecies = dependecies
  }
  
  func start() {
    let g1NavigationController = UINavigationController()
    let agroNavigationController = UINavigationController()
    let menuNavigationController = UINavigationController()
    
    let g1Dependecies = FeedDIContainer(
      product: "g1",
      title: "G1",
      networkService: dependecies.networkService
    )
    let agroDependecies = FeedDIContainer(
      product: "https://g1.globo.com/economia/agronegocios/",
      title: "Agronegócio",
      networkService: dependecies.networkService
    )
    let menuDependecies = MenuDIContainer(
      fileReaderService: dependecies.fileReaderService
    )
    
    let g1Coodinator = FeedCoordinator(
      navigation: g1NavigationController,
      dependecies: g1Dependecies
    )
    let agroCoodinator = FeedCoordinator(
      navigation: agroNavigationController,
      dependecies: agroDependecies
    )
    let menuCoodinator = MenuCoordinator(
      navigation: menuNavigationController,
      dependecies: menuDependecies
    )
    
    g1NavigationController.tabBarItem = UITabBarItem(
      title: "G1",
      image: UIImage(systemName: "newspaper"),
      tag: 0
    )
    agroNavigationController.tabBarItem = UITabBarItem(
      title: "Agronegócio",
      image: UIImage(systemName: "newspaper"),
      tag: 1
    )
    menuNavigationController.tabBarItem = UITabBarItem(
      title: "Menu",
      image: UIImage(systemName: "list.triangle"),
      tag: 2
    )
    
    g1Coodinator.start()
    agroCoodinator.start()
    menuCoodinator.start()
    
    tabBarController.viewControllers = [
      g1NavigationController,
      agroNavigationController,
      menuNavigationController,
    ]
    
    children.append(g1Coodinator)
    children.append(agroCoodinator)
    children.append(menuCoodinator)
  }
}

