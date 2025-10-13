//
//  UITableView+Extensions.swift
//  NewsApp
//
//  Created by Guilherme Prates on 13/10/25.
//

import UIKit

extension UITableView {
  
  func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
      fatalError(
        """
        Couldn't find UITableViewCell for \(T.identifier)), 
        make sure the cell is registered with table view
        """
      )
    }
    return cell
  }
  
  func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError(
        """
        Couldn't find UITableViewCell for \(T.identifier),
        make sure the cell is registered with table view
        """
      )
    }
    return cell
  }
  
  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
    guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as? T else {
      fatalError(
        """
        Couldn't find UITableViewHeaderFooterView for \(T.identifier), 
        make sure the view is registered with table view
        """
      )
    }
    return headerFooterView
  }
  
  func register(nib: UINib?, withHeaderFooterViewClass name: (some UITableViewHeaderFooterView).Type) {
    register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
  }
  
  func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
    register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
  }
  
  func register<T: UITableViewCell>(cellWithClass name: T.Type) {
    register(T.self, forCellReuseIdentifier: String(describing: name))
  }
  
  func register(nib: UINib?, withCellClass name: (some UITableViewCell).Type) {
    register(nib, forCellReuseIdentifier: String(describing: name))
  }
  
  func register(nibWithCellClass name: (some UITableViewCell).Type, at bundleClass: AnyClass? = nil) {
    let identifier = String(describing: name)
    var bundle: Bundle?
    
    if let bundleName = bundleClass {
      bundle = Bundle(for: bundleName)
    }
    
    register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
  }
}
