//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//


import UIKit
import SwiftUI
import SnapKit
import Combine

final class FeedViewController: UIViewController {
  
  private typealias FeedDataSource = UICollectionViewDiffableDataSource<FeedSection, FeedItem>
  
  private enum FeedSection: Int {
    case main = 0
  }
  
  private lazy var dataSource: FeedDataSource = {
    dataSource = FeedDataSource(collectionView: collectionView) { collectionView, indexPath, item in
      let cell = collectionView.dequeueReusableCell(withClass: FeedItemCell.self, for: indexPath)
      let viewModel = FeedItemViewModel(item: item)
      cell.configure(viewModel: viewModel, parent: self)
      cell.backgroundColor = .blue
      return cell
    }
    return dataSource
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: view.frame,
      collectionViewLayout: makeCollectionViewLayout()
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.alwaysBounceVertical = true
    collectionView.backgroundColor = .lightGray
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionView.register(cellWithClass: FeedItemCell.self)
    collectionView.refreshControl = refreshControl
    return collectionView
  }()
  
  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    refreshControl.tintColor = .white
    return refreshControl
  }()
  
  private var viewModel: FeedViewModel
  
  private var cancellables = Set<AnyCancellable>()
  
  var goToWebView: ((_ url: URL) -> Void)?
  
  init(viewModel: FeedViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.prefetchDataSource = self
    collectionView.dataSource = dataSource
    
    binds()
    setupViews()
   
    viewModel.loadFeed()
  }
  
  private func binds() {
    viewModel.$items
      .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
      .map { items -> NSDiffableDataSourceSnapshot<FeedSection, FeedItem> in
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, FeedItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        return snapshot
      }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] snapshot in
        self?.dataSource.apply(snapshot, animatingDifferences: true)
      }
      .store(in: &cancellables)
    
    viewModel.$errorMessage
      .filter { $0 != nil }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] message in
        self?.showAlert(title: "Erro", message: message)
      }
      .store(in: &cancellables)
    
    viewModel.$isLoading
      .receive(on: DispatchQueue.main)
      .sink { [weak self] loading in
        if !loading {
          self?.refreshControl.endRefreshing()
        }
      }
      .store(in: &cancellables)
  }
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  @objc
  private func didPullToRefresh() {
    viewModel.loadFeed()
  }
}

// MARK: - UICollectionViewDelegate
extension FeedViewController: UICollectionViewDelegate {
 
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let snapshot = dataSource.snapshot()
    let item = snapshot.itemIdentifiers[indexPath.item]
    guard let url = item.url else { return }
    goToWebView?(url)
  }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension FeedViewController: UICollectionViewDataSourcePrefetching {
  
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    guard let lastIndex = dataSource.snapshot().itemIdentifiers(inSection: .main).indices.last else { return }
    if indexPaths.contains(where: { $0.item >= lastIndex - 10 }) {
      viewModel.loadNextPage()
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController {
  
  private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
      if section == 0 {
        // Item
        let item = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
          )
        )
        // group
        let group = NSCollectionLayoutGroup.vertical(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
          ),
          subitems: [item]
        )
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
      }
      return nil
    }
  }
}

