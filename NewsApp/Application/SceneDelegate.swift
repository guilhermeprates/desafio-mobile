//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private let appConfiguration = AppConfiguration()
  
  private var coordinator: AppCoordinator?
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }
    
    let appDIContainer = AppDIContainer(appConfiguration: appConfiguration)
    let controller = UITabBarController()
    coordinator = AppCoordinator(tabBarController: controller, dependecies: appDIContainer)
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

