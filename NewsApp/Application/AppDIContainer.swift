//
//  AppDIContainer.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit

final class AppDIContainer {
  
  private(set) var appConfiguration: AppConfiguration

  lazy var networkService: NetworkService = {
    do {
      let baseURL = try appConfiguration.apiBaseURL
      let configuration = DefaultNetworkConfig(baseURL: baseURL)
      return NetworkService(configuration: configuration)
    } catch {
      fatalError("Could not create NetworkService: \(error)")
    }
  }()
  
  lazy var fileReaderService: FileReaderService = {
    return FileReaderService()
  }()
  
  init(appConfiguration: AppConfiguration) {
    self.appConfiguration = appConfiguration
  }
}
