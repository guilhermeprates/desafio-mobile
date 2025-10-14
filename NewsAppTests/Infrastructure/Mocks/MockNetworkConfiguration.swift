//
//  MockNetworkConfiguration.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation

@testable import NewsApp

struct MockNetworkConfig: NetworkConfiguration {
  let baseURL: URL = URL(string: "https://api.test.com")!
  let headers: [String: String] = [:]
  let queryParameters: [String: String] = [:]
  let decoder: JSONDecoder = JSONDecoder()
  let timeout: Double = 30
}
