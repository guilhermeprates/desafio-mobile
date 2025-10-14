//
//  NetworkService.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation
import Combine

enum NetworkError: Error {
  case invalidURL
  case requestFailed(_ error: URLError)
  case httpStatus(code: Int, data: Data?)
  case decodingFailed(error: Error, data: Data?)
  case unknown(Error)
}

final class NetworkService {
  
  private let configuration: NetworkConfiguration
  
  init(configuration: NetworkConfiguration) {
    self.configuration = configuration
  }
  
  func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, NetworkError> {
    requestData(endpoint)
      .tryMap { [decoder = configuration.decoder] data in
        do {
          return try decoder.decode(T.self, from: data) }
        catch {
          throw NetworkError.decodingFailed(error: error, data: data)
        }
      }
      .mapError { mapError($0) }
      .eraseToAnyPublisher()
  }
  
  func requestData(_ endpoint: Endpoint) -> AnyPublisher<Data, NetworkError> {
    guard var components = URLComponents(
      url: configuration.baseURL.appendingPathComponent(endpoint.path),
      resolvingAgainstBaseURL: false
    ) else {
      return Fail(error: .invalidURL).eraseToAnyPublisher()
    }
    
    if !endpoint.query.isEmpty {
      components.queryItems = endpoint.query.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    guard let url = components.url else {
      return Fail(error: .invalidURL).eraseToAnyPublisher()
    }
    
    var request = URLRequest(url: url, timeoutInterval: configuration.timeout)
    request.httpMethod = endpoint.method.rawValue
    endpoint.headers.forEach {
      request.setValue($0.value, forHTTPHeaderField: $0.key)
    }
    request.httpBody = endpoint.body

    return URLSession.shared
      .dataTaskPublisher(for: request)
      .tryMap { output -> Data in
        if let http = output.response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
          throw NetworkError.httpStatus(code: http.statusCode, data: output.data)
        }
        return output.data
      }
      .mapError { mapError($0) }
      .eraseToAnyPublisher()
  }
}

// MARK: - Helpers

private func mapError(_ error: Error) -> NetworkError {
  if let networkError = error as? NetworkError { return networkError }
  if let urlError = error as? URLError { return .requestFailed(urlError) }
  return .unknown(error)
}
