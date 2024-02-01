
//
//  LoginViewController.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2024/01/28.
//
import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.cornerRadius = 10.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "vkBlue")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImageView, emailTextField, passwordTextField, loginButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        // ScrollView constraints
        scrollView.pinToEdges(of: view)
        
  
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
    
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120.0),
            logoImageView.widthAnchor.constraint(equalToConstant: 100.0),
            logoImageView.heightAnchor.constraint(equalToConstant: 100.0)
        ])

       
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120.0),
            emailTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32.0),
            emailTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ])

      
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16.0),
            passwordTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32.0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50.0)
        ])

       
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16.0),
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    
}

extension UIView {
    func pinToEdges(of superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
}
