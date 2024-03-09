//
//  ViewController.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2023/11/08.
//
import Foundation
import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    private var photoGallery: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        setupTableView()
    }

    private func loadImages() {
        for i in 1...20 {
            if let image = UIImage(named: String(format: "%02d", i)) {
                photoGallery.append(image)
            }
        }
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
      
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return section == 0 ? 1 : 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                fatalError("PhotosTableViewCell not found")
            }
            
            cell.configure(with: Array(photoGallery.prefix(4)))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherCell", for: indexPath)
        
            cell.textLabel?.text = "Row \(indexPath.row)"
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return indexPath.section == 0 ? 200 : UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : UITableView.automaticDimension
    }
}
