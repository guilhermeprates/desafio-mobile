//
//  FeedItemCell.swift
//  NewsApp
//
//  Created by Guilherme Prates on 14/10/25.
//

import UIKit
import SwiftUI
import SnapKit

final class FeedItemCell: UICollectionViewCell {
  
  private var hostingController: UIHostingController<FeedItemView>? = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupConstraints()
  }
  
  private func setupConstraints() {
    guard let hostingView = hostingController?.view else {
      return
    }
    hostingView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(hostingView)
    
    hostingView.snp.makeConstraints { make in
      make.edges.equalTo(contentView.snp.edges)
    }
  }
  
  func configure(viewModel: FeedItemViewModel) {
    if #available(iOS 16.0, *) {
      contentConfiguration = UIHostingConfiguration {
        return FeedItemView(viewModel: viewModel)
      }.margins(.all, 0)
    } else {
      if hostingController != nil {
        hostingController?.rootView = FeedItemView(viewModel: viewModel)
      } else {
        let newHostingController = UIHostingController(rootView: FeedItemView(viewModel: viewModel))
        hostingController = newHostingController
        addSubview(newHostingController.view)
        newHostingController.view.frame = bounds
        setupConstraints()
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    hostingController?.view.invalidateIntrinsicContentSize()
  }
}
