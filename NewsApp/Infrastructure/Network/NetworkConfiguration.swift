//
//  NetworkConfiguration.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation

protocol NetworkConfiguration {
  var baseURL: URL { get }
  var headers: [String: String] { get }
  var queryParameters: [String: String] { get }
  var decoder: JSONDecoder { get }
  var timeout: Double { get }
}

struct DefaultNetworkConfig: NetworkConfiguration {
  let baseURL: URL
  let headers: [String: String]
  let queryParameters: [String: String]
  let decoder: JSONDecoder
  let timeout: Double
  
  init(
    baseURL: URL,
    headers: [String: String] = [:],
    queryParameters: [String: String] = [:],
    decoder: JSONDecoder = JSONDecoder(),
    timeout: Double = 30
  ) {
    self.baseURL = baseURL
    self.headers = headers
    self.queryParameters = queryParameters
    self.decoder = decoder
    self.timeout = timeout
  }
}
