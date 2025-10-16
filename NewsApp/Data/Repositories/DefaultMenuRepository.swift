//
//  DefaultMenuRepository.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import Foundation
import Combine

final class DefaultMenuRepository: MenuRepository {
  
  private let fileReaderService: FileReaderService
 
  init(fileReaderService: FileReaderService) {
    self.fileReaderService = fileReaderService
  }
  
  func fetchMenu(resource name: String) throws -> Menu {
    return try fileReaderService.decode(Menu.self, from: name)
  }
}
