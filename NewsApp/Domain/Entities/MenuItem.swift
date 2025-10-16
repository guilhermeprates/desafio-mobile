//
//  MenuItem.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import Foundation

typealias MenuItems = [MenuItem]

nonisolated struct MenuItem: Decodable {
  let title: String
  let url: URL
}
