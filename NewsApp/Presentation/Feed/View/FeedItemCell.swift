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
  
  private var host: UIHostingController<FeedItemView>?
    
  func configure(viewModel: FeedItemViewModel, parent: UIViewController) {
    if #available(iOS 16.0, *) {
      contentConfiguration = UIHostingConfiguration {
        return FeedItemView(viewModel: viewModel)
      }.margins(.all, 0)
    } else {
      if let host = self.host {
        host.rootView = FeedItemView(viewModel: viewModel)
        host.view.layoutIfNeeded()
      } else {
        let host = UIHostingController(rootView: FeedItemView(viewModel: viewModel))
        parent.addChild(host)
        host.didMove(toParent: parent)
        host.view.frame = self.contentView.bounds
        contentView.addSubview(host.view)
        self.host = host
      }
    }
  }
  
  deinit {
    host?.willMove(toParent: nil)
    host?.view.removeFromSuperview()
    host?.removeFromParent()
    host = nil
  }
}
