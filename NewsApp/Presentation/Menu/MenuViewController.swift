//
//  MenuViewController.swift
//  NewsApp
//
//  Created by Guilherme Prates on 16/10/25.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {

  private var repository: MenuRepository
  
  private var menuItems: MenuItems = []
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.separatorStyle = .singleLine
    tableView.separatorColor = UIColor.lightGray
    tableView.backgroundColor = UIColor.white
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 40
    tableView.register(cellWithClass: UITableViewCell.self)
    return tableView
  }()
  
  var goToWebView: ((_ url: URL) -> Void)?
  
  init(repository: MenuRepository) {
    self.repository = repository
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    do {
      let menu = try repository.fetchMenu(resource: "Menu")
      menuItems = menu.menuItems
      tableView.reloadData()
    } catch {
      showAlert(title: "Error", message: "Ops! Algo de errado aconteceu.")
    }
  }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let url = menuItems[indexPath.row].url
    goToWebView?(url)
  }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = menuItems[indexPath.row].title
    cell.contentConfiguration = content
    cell.selectionStyle = .none
    return cell
  }
}
