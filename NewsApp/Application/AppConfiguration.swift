//
//  AppConfiguration.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation

final class AppConfiguration {
  
  private enum InfoPlist: String {
    case apiBaseURL = "API Base URL"
  }
  
  private enum Plist {
    
    enum Error: Swift.Error {
      case missingKey, invalidValue
    }
    
    static func value<T>(for key: InfoPlist) throws -> T where T: LosslessStringConvertible {
      guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
        throw Error.missingKey
      }
      
      switch object {
        case let value as T:
          return value
        case let string as String:
          guard let value = T(string) else { fallthrough }
          return value
        default:
          throw Error.invalidValue
      }
    }
  }
  
  var apiBaseURL: URL {
    get throws {
      let baseURL: String = try Plist.value(for: .apiBaseURL)
      return try URL(string: baseURL)
    }
  }
}
