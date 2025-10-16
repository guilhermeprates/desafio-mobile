//
//  MenuRepository.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import Foundation
import Combine

protocol MenuRepository {
  @discardableResult
  func fetchMenu(resource name: String) throws -> Menu
}
