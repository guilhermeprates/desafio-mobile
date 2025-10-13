//
//  URL+Extensions.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation

extension URL {
  enum URLError: Swift.Error {
    case invalidURL(String)
  }
  
  init(string: String) throws {
    guard let url = URL(string: string) else {
      throw URLError.invalidURL(string)
    }
    self = url
  }
}
