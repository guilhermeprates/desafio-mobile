//
//  Coordinator.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit

protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
  func start()
}

protocol TabBarCoordinator: Coordinator & UITabBarControllerDelegate {
  var tabBarController: UITabBarController { get set }
}

protocol FlowCoordinator: Coordinator {
  var navigation: UINavigationController { get set }
}



