//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  private let configuration = AppConfiguration()
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    
    do {
      let apiBaseURL = try configuration.apiBaseURL
    } catch {
      dump(error)
    }
    
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = FeedViewController()
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {}
}

