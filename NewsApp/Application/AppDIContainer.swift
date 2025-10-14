//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import Foundation

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
}
