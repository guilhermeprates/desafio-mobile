//
//  NetworkServiceTests.swift
//  NewsAppTests
//
//  Created by Guilherme Prates on 13/10/25.
//

import Foundation
import Combine
import Testing

@testable import NewsApp

@Suite("NetworkService tests")
struct NetworkServiceTests {
  
  private struct StatusCode {
    
    static var successCodes = [
      200, 201, 202, 203, 205, 206, 207, 208, 226
    ]
    
    static var errorCodes = [
      400,401,402,403,404,405,406,407,408,409,410,411,412,
      413,414,415,416,417,418,421,422,423,424,425,426,428,
      429,431,451,500,501,502,503,504,505,506,507,508,510,
      511
    ]
  }
  
  private var cancellables: Set<AnyCancellable> = []
  
  @Test(arguments: StatusCode.successCodes)
  mutating func WhenRequestSuccess(with statusCode: Int) {
    URLProtocol.registerClass(MockURLProtocol.self)
    
    let expected = Data(#"{"id": 1}"#.utf8)
    
    MockURLProtocol.requestHandler = { request in
      let url = try #require(request.url)
      let data = Data(#"{"id": 1}"#.utf8)
      let response = HTTPURLResponse(
        url: url,
        statusCode: statusCode,
        httpVersion: "HTTP/1.1",
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, data)
    }
    
    let configuration = MockNetworkConfig()
    let sut = NetworkService(configuration: configuration)
    let endpoint = Endpoint("/mock")
    
    sut.requestData(endpoint)
      .sink(receiveCompletion: { completion in
        guard case .finished = completion else { return }
      }, receiveValue: { data in
        #expect(data == expected)
      })
      .store(in: &cancellables)
    
    cancellables.removeAll()
    MockURLProtocol.requestHandler = nil
    URLProtocol.unregisterClass(MockURLProtocol.self)
  }
  
  @Test(arguments: StatusCode.errorCodes)
  mutating func WhenRequestFailed(with statusCode: Int) {
    URLProtocol.registerClass(MockURLProtocol.self)
    
    MockURLProtocol.requestHandler = { request in
      let url = try #require(request.url)
      let data = Data(#"{"error":"data not found"}"#.utf8)
      let response = HTTPURLResponse(
        url: url,
        statusCode: statusCode,
        httpVersion: "HTTP/1.1",
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, data)
    }
    
    let configuration = MockNetworkConfig()
    let sut = NetworkService(configuration: configuration)
    let endpoint = Endpoint("/mock")
    
    sut.requestData(endpoint)
      .sink(receiveCompletion: { completion in
        guard case .failure(let error) = completion else { return }
        switch error {
          case .httpStatus(let code, let data):
            #expect(code == statusCode)
            #expect(String(data: data ?? Data(), encoding: .utf8) == #"{"error":"data not found"}"#)
          default:
            Issue.record("Wrong error mapping: \(error)")
        }
      }, receiveValue: { _ in
        Issue.record("Should not succeed")
      })
      .store(in: &cancellables)
    
    cancellables.removeAll()
    MockURLProtocol.requestHandler = nil
    URLProtocol.unregisterClass(MockURLProtocol.self)
  }
  
  @Test
  mutating func whenRequestSuccessDecodesModel() {
    let expected = MockData(id: 1)
    
    MockURLProtocol.requestHandler = { request in
      let url = try #require(request.url)
      let data = try JSONEncoder().encode(MockData(id: 1))
      let response = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: "HTTP/1.1",
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, data)
    }
    
    let configuration = MockNetworkConfig()
    let sut = NetworkService(configuration: configuration)
    let endpoint = Endpoint("/mock")
    
    sut.request(endpoint)
      .sink(receiveCompletion: { completion in
        if case .failure(let error) = completion {
          Issue.record("Unexpected error: \(error)")
        }
    }, receiveValue: { (mockData: MockData) in
      #expect(mockData == expected)
    })
    .store(in: &cancellables)
  }
  
  @Test
  mutating func WhenRequestFailDecodeModel() {
    MockURLProtocol.requestHandler = { request in
      let url = try #require(request.url)
      let data = Data(#"{"id":"not-an-int"}"#.utf8)
      let response = HTTPURLResponse(
        url: url,
        statusCode: 200,
        httpVersion: "HTTP/1.1",
        headerFields: ["Content-Type": "application/json"]
      )!
      return (response, data)
    }
    
    let configuration = MockNetworkConfig()
    let sut = NetworkService(configuration: configuration)
    let endpoint = Endpoint("/mock")
    
    sut.request(endpoint)
      .sink(receiveCompletion: { completion in
        guard case .failure(let error) = completion else { return }
        if case .decodingFailed(_, let data) = error {
          #expect(String(data: data ?? Data(), encoding: .utf8) == #"{"id":"not-an-int"}"#)
        } else {
          Issue.record("Expected decodingFailed: \(error)")
        }
      }, receiveValue: { (mockData: MockData) in
        Issue.record("Should not decode.")
      })
      .store(in: &cancellables)
  }
}
