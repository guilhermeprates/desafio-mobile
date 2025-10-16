//
//  FeedItemView.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import SwiftUI
import Kingfisher

struct FeedItemView: View {
  
  @ObservedObject
  var viewModel: FeedItemViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if !viewModel.chapeu.isEmpty {
        Text(viewModel.chapeu)
          .lineLimit(1)
          .fixedSize(horizontal: false, vertical: true)
      }
      if !viewModel.title.isEmpty {
        Text(viewModel.title)
          .font(.headline)
          .lineLimit(3)
          .fixedSize(horizontal: false, vertical: true)
          .layoutPriority(1)
      }
      if let image = viewModel.image {
        KFImage(image)
          .resizable()
          .scaledToFill()
          .frame(height: 200)
          .clipped()
          .clipShape(.rect(cornerRadius: 8))
      }
      if !viewModel.summary.isEmpty {
        Text(viewModel.summary)
          .lineLimit(4)
          .fixedSize(horizontal: false, vertical: true)
      }
      Text(viewModel.metadata)
        .font(.footnote)
        .lineLimit(1)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(16)
    .background(.white)
  }
}
