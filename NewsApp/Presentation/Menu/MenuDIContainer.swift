//
//  MenuDIContainer.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import UIKit

final class MenuDIContainer {
  
  private(set) var fileReaderService: FileReaderService
  
  init(fileReaderService: FileReaderService) {
    self.fileReaderService = fileReaderService
  }
}
