//
//  EndPoint.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation

enum HTTPMethodType: String {
  case get     = "GET"
  case head    = "HEAD"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
}

struct Endpoint {
  let path: String
  let method: HTTPMethodType
  var query: [String: String] = [:]
  var headers: [String: String] = [:]
  var body: Data? = nil
  
  init(
    _ path: String,
    method: HTTPMethodType = .get,
    query: [String: String] = [:],
    headers: [String: String] = [:],
    body: Data? = nil
  ) {
    self.path = path
    self.method = method
    self.query = query
    self.headers = headers
    self.body = body
  }
}
