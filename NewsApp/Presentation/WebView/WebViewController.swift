//
//  WebViewController.swift
//  NewsApp
//
//  Created by Guilherme Prates on 15/10/25.
//

import UIKit
import WebKit
import SnapKit

final class WebViewController: UIViewController {
  
  private lazy var webView: WKWebView = {
    let webView = WKWebView()
    webView.translatesAutoresizingMaskIntoConstraints = false
    return webView
  }()
  
  private var url: URL
  
  init(url: URL) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    let request = URLRequest(url: url)
    webView.load(request)
  }
}
