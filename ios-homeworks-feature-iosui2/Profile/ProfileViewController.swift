


import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }
    
    private func setupConstraints() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220.0)
        ])
    }
    @objc func profileButtonTapped() {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    func setupProfileButton() {
        let profileButton = UIButton()
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
}
