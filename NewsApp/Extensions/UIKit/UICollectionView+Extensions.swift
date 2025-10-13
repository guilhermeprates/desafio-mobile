//
//  UICollectionView+Extensions.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import UIKit

extension UICollectionView {
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    withClass name: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError(
        """
        Couldn't find UICollectionViewCell for \(T.identifier), 
        make sure the cell is registered with collection view
        """
      )
    }
    return cell
  }
  
  func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
    ofKind kind: String,
    withClass name: T.Type,
    for indexPath: IndexPath
  ) -> T {
    guard let cell = dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: String(describing: name),
      for: indexPath) as? T else {
      fatalError(
        """
        Couldn't find UICollectionReusableView for \(T.identifier), 
        make sure the view is registered with collection view
        """
      )
    }
    return cell
  }
  
  func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
  }
  
  func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
    register(nib, forCellWithReuseIdentifier: T.identifier)
  }
  
  func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.identifier)
  }
  
  func register<T: UICollectionReusableView>(
    nib: UINib?, forSupplementaryViewOfKind kind: String,
    withClass name: T.Type
  ) {
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
  }
  
  func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
    let identifier = String(describing: name)
    var bundle: Bundle?
    
    if let bundleName = bundleClass {
      bundle = Bundle(for: bundleName)
    }
    
    register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
  }
}

