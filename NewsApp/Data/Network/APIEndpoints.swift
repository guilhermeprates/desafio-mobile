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
  
  static func getFeedPage(parameters: PageParameters) -> Endpoint {
    let product = parameters.product
    let id = parameters.id
    let page = parameters.page
    return Endpoint("/feed/page/\(product)/\(id)/\(page)", method: .get)
  }
}
