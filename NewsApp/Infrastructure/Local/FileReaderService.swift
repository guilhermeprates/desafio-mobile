//
//  FileReaderService.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import Foundation

public enum FileReadError: Error {
  case fileNotFound(String)
  case decoding(Error)
  case unknown(Error)
}

final class FileReaderService {
  
  private let bundle: Bundle
  
  init(bundle: Bundle = .main) {
    self.bundle = bundle
  }
  
  func data(from name: String, ext: String = "json") throws -> Data {
    guard let url = bundle.url(forResource: name, withExtension: ext) else {
      throw FileReadError.fileNotFound("\(name).\(ext)")
    }
    do {
      return try Data(contentsOf: url)
    } catch {
      throw FileReadError.unknown(error)
    }
  }
  
  func decode<T: Decodable>(
    _ type: T.Type,
    from name: String,
    ext: String = "json",
    decoder: JSONDecoder = JSONDecoder()
  ) throws -> T {
    let data = try data(from: name, ext: ext)
    do {
      return try decoder.decode(T.self, from: data)
    } catch {
      throw FileReadError.decoding(error)
    }
  }
}
