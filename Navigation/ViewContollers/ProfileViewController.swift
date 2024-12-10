
// ProfileViewController.swift

import UIKit

final class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var coordinator: ProfileCoordinator?

    static let headerIdent = "header"
    static let photoIdent = "photo"
    static let postIdent = "post"
   
    var user: User?  // Свойство для пользователя

    private let postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoIdent)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: postIdent)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        view.backgroundColor = .systemBackground

        #if DEBUG
        view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .blue
        #endif

        view.addSubview(postTableView)
        setupConstraints()
        postTableView.dataSource = self
        postTableView.delegate = self
        postTableView.refreshControl = UIRefreshControl()
        postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func reloadTableView() {
        postTableView.reloadData()
        postTableView.refreshControl?.endRefreshing()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return postExamples.count
        default:
            assertionFailure("no registered section")
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.photoIdent, for: indexPath) as! PhotosTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
            cell.configPost(post: postExamples[indexPath.row])
            return cell
        default:
            assertionFailure("no registered section")
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdent) as! ProfileHeaderView
        if let user = user {
            headerView.setup(with: user)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
            coordinator?.showPhotos()
        case 1:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            if let post = cell as? PostTableViewCell {
                post.incrementPostViewsCounter()
            }
        default:
            assertionFailure("no registered section")
        }
    }
}
