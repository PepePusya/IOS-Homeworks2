//
//  VideoViewController.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/08/21.
//

import Foundation

import UIKit
import WebKit

final class VideoViewController: UIViewController {
    
    var videoURL: String?
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        loadVideo()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadVideo() {
        guard let videoURL = videoURL, let url = URL(string: videoURL) else {
            print("Invalid video URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
