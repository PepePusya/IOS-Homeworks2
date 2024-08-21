//
//  VideoFeedViewController.swift
//  Navigation
//
//  Created by Anna Zaytseva on 2024/08/21.
//

import UIKit
import WebKit

final class VideoFeedViewController: UIViewController {
    
    private let videos = [ ("ГЛАВНОЕ ЧИСЛО ВСЕЛЕННОЙ — ТОПЛЕС", "https://youtu.be/hfFSpqcjX6c?si=W_r_24jRN1794O3p"),
                           ("Как работает НАТАЛЬНАЯ КАРТА, ТАРО, АСТРОЛОГИЯ и ИНФОЦЫГАНЕ? — ТОПЛЕС", "https://youtu.be/r_WuDtcXbOg?si=PaXm9HVyXSUXa9Gh"),
                           ("ЗАГАДКА ЧЕЛОВЕКА-ФАКЕЛА — ТОПЛЕС", "https://youtu.be/sDlReEu2f_k?si=hcAdo1atfAuSfl8h")
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension VideoFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row].0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let videoURL = videos[indexPath.row].1
        let videoViewController = VideoViewController()
        videoViewController.videoURL = videoURL
        navigationController?.pushViewController(videoViewController, animated: true)
    }
}
