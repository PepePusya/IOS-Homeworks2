

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
    
    let setStatusButton: UIButton = {
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
    
    let fullNameLabel: UILabel = {
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
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Input Text"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .systemBrown
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        return textField
        
        
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
        addSubview(setStatusButton)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
            avatarImageView.leadingAnchor.constraint(equalTo:safeAreaGuide.leadingAnchor, constant: 16.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90.0),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16.0),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 27.0),
            fullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: -84.0),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 8.0),
            statusTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            statusTextField.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    @objc private func buttonPressed() {
        print(statusLabel.text ?? "")
    }
}


