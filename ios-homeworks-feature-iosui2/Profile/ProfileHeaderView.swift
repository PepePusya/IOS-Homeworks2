//
//  ProfileHeaderView.swift
//  ios-homeworks-feature-iosui2
//
//  Created by Anna Zaytseva on 2023/11/08.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "avatarImage")
    imageView.layer.cornerRadius = 45.0
    imageView.layer.borderWidth = 3.0
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.masksToBounds = true
    return imageView
}()
    
    let statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    } ()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Pepe cat"
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        label.text = "Looking for something to eat"
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(statusButton)
        addSubview(profileNameLabel)
        addSubview(statusLabel)
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
            avatarImageView.leadingAnchor.constraint(equalTo:safeAreaGuide.leadingAnchor, constant: 16.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90.0),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16.0),
            statusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            statusButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            profileNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27.0),
            profileNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: -84.0),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc private func buttonPressed() {
        print(statusLabel.text ?? "")
    }
}

/*
 class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatarImage")
        imageView.layer.cornerRadius = 50.0
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    } ()
    let statusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
        
    }()
    
    let profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.text = "Pepe cat"
        return label
        
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        label.text = "Looking for love, affection and something to eat..."
        return label
        
    }()
    @objc func buttonPressed() {
        print(statusLabel.text ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        private func setupUI() {
            addSubview(avatarImageView)
            addSubview(statusButton)
            addSubview(profileNameLabel)
            addSubview(statusLabel)
            
            let safeAreaGuide = self.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                
                avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
                avatarImageView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
                avatarImageView.widthAnchor.constraint(equalToConstant: 100.0),
                avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
                
                statusButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 34.0),
                statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16.0),
                statusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
                statusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
                statusButton.heightAnchor.constraint(equalToConstant: 50),
                
                
                profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27.0),
                profileNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                statusLabel.topAnchor.constraint(equalTo: statusButton.bottomAnchor, constant: -34.0),
                statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
                
            ])
            statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
        
    }
 */
    /*
     let profileNameLabel: UILabel = {
     let label = UILabel()
     
     label.translatesAutoresizingMaskIntoConstraints = false
     label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
     label.textColor = .black
     label.text = "Profile"
     return label
     }()
     let avatarImageView: UIImageView = {
     let imageView = UIImageView()
     imageView.translatesAutoresizingMaskIntoConstraints = false
     imageView.image = UIImage(named: "avatarImage")
     imageView.contentMode = .scaleAspectFit
     return imageView
     }()
     
     let statusLabel: UILabel = {
     let label = UILabel()
     label.translatesAutoresizingMaskIntoConstraints = false
     label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
     label.textColor = .gray
     label.text = "Looking for love, affection and something to eat..."
     return label
     }()
     let statusButton: UIButton = {
     let button = UIButton(type: .system)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.setTitle("Show status", for: .normal)
     button.setTitleColor(.white, for: .normal)
     button.backgroundColor = .blue
     button.backgroundColor = .black
     button.layer.cornerRadius = 4.0
     button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
     return button
     }()
     
     @objc func buttonPressed() {
     print (statusLabel.text)
     }
     override init(frame:CGRect){
     super.init(frame: frame)
     setupUI()
     }
     required init?(coder: NSCoder) {
     super.init(coder: coder)
     setupUI()
     }
     private func setupUI() {
     addSubview(profileNameLabel)
     addSubview(avatarImageView)
     addSubview(statusLabel)
     addSubview(statusButton)
     
     NSLayoutConstraint.activate([
     profileNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 16.0),
     profileNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 27)
     ])
     }
     }
     */

