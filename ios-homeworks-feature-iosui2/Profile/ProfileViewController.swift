
import UIKit

class ProfileViewController: UIViewController {
    
    private var tableView: UITableView!
    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadDummyData()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        
       
        let headerView = ProfileHeaderView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 220) //
        tableView.tableHeaderView = headerView
    }

    private func loadDummyData() {
       
        posts = [
            Post (author: "Pepe Cat", description: "She is a Liar", imageName: "liarCat", likes: 120, views: 300),
            Post(author: "Crazy Dog", description: "Miting with Pepe Cat", imageName: "postImage1", likes: 100, views: 230)
            
            
            
        ]
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            fatalError("Cell not found")
        }
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}


extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}
