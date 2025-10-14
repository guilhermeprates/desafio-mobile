//
//  MockData.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

struct MockData: Codable, Equatable {
  let id: Int
  
  static func == (lhs: MockData, rhs: MockData) -> Bool {
    return lhs.id == rhs.id
  }
}
