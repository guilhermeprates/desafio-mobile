//
//  APIEndpoints.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

struct APIEndpoints {
  
  static func getFeedPage(product: String) -> Endpoint {
    return Endpoint("/feed/\(product)", method: .get)
  }
  
  static func getFeedPage(product: String, id: Int, page: Int) -> Endpoint {
    return Endpoint("/feed/\(product)/\(id)/\(page)", method: .get)
  }
}
