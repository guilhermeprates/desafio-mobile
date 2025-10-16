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
    Group {
      VStack(alignment: .leading) {
        if !viewModel.chapeu.isEmpty {
          Text(viewModel.chapeu)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
        }
        if !viewModel.title.isEmpty {
          Text(viewModel.title)
            .lineLimit(3)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
        }
        if let image = viewModel.image {
          KFImage(image)
            .resizable()
            .scaledToFill()
            .frame(maxHeight: 200)
            .clipShape(.rect(cornerRadius: 8))
          Spacer()
        }
        if !viewModel.summary.isEmpty {
          Text(viewModel.summary)
            .lineLimit(4)
            .frame(maxWidth: .infinity, alignment: .leading)
          Spacer()
        }
        Text(viewModel.metadata)
          .lineLimit(1)
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(16)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.white)
  }
}
