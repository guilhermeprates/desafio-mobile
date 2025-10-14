//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private let appDIContainer = AppDIContainer()
  
  private var coordinator: AppCoordinator?
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let controller = UITabBarController()
    coordinator = AppCoordinator(tabBarController: controller, container: appDIContainer)
    coordinator?.start()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {}
}

