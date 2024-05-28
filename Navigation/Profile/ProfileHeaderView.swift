//
//  ProfileHeaderView.swift
//  Navigation
//

import UIKit
import SnapKit

final class ProfileHeaderView: UITableViewHeaderFooterView {

    // MARK: Visual objects

    var fullNameLabel = UILabel()
    var avatarImageView = UIImageView()
    var statusLabel = UILabel()
    var statusTextField = UITextField()
    var setStatusButton = UIButton()
    var returnAvatarButton = UIButton()
    var avatarBackground = UIView()

    private var statusText = "Looking for something to eat"
    private var avatarOriginPoint = CGPoint()
    
 
    func setup(with user: User) {
        fullNameLabel.text = user.fullName
        avatarImageView.image = user.avatar
        statusLabel.text = user.status
        statusTextField.text = user.status
    }
    // MARK: - Setup section

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupNameLabel()
        setupStatusLabel()
        setupStatusTextField()
        setupStatusButton()
        setupAvatarImage()

        statusTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNameLabel() {
        addSubview(fullNameLabel)
        fullNameLabel.text = "Pepe cat"
        fullNameLabel.font = .boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black

        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(156)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(28)
        }
    }

    private func setupStatusLabel() {
        addSubview(statusLabel)
        statusLabel.text = statusText
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textColor = .black

        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
            make.height.equalTo(fullNameLabel.snp.height)
        }
    }

    private func setupStatusTextField() {
        addSubview(statusTextField)
        statusTextField.textColor = .darkGray
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 8
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.gray.cgColor
        statusTextField.attributedPlaceholder = NSAttributedString(string: "Ready...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        statusTextField.leftViewMode = .always
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.trailing.equalTo(fullNameLabel.snp.trailing)
            make.height.equalTo(32)
        }
    }

    private func setupStatusButton() {
        addSubview(setStatusButton)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 12
        setStatusButton.setTitle("Show Status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)

        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.height.equalTo(48)
        }
    }

    private func setupAvatarImage() {
        addSubview(avatarImageView)
        avatarImageView.image = UIImage(named: "avatarImage")
        avatarImageView.layer.cornerRadius = 64
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true

        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.width.height.equalTo(128)
        }

        addSubview(returnAvatarButton)
        returnAvatarButton.alpha = 0
        returnAvatarButton.backgroundColor = .clear
        returnAvatarButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
        returnAvatarButton.tintColor = .black

        returnAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
       
        addSubview(avatarBackground)
        avatarBackground.backgroundColor = .darkGray
        avatarBackground.isHidden = true
        avatarBackground.alpha = 0

        avatarBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

       
    }

    // MARK: - Event handlers
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
        statusLabel.text = statusText
    
    }

    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
    }


    
    @objc private func didTapOnAvatar() {
        avatarOriginPoint = avatarImageView.center
        let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width

        UIView.animate(withDuration: 0.5, animations: {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.returnAvatarButton.alpha = 1
            }
        }
    }

    @objc private func returnAvatarToOrigin() {
        UIView.animate(withDuration: 0.5, animations: {
            self.returnAvatarButton.alpha = 0
            self.avatarImageView.center = self.avatarOriginPoint
            self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.avatarImageView.layer.cornerRadius = 64
            self.avatarBackground.alpha = 0
        }) { _ in
            self.avatarBackground.isHidden = true
            self.avatarImageView.isUserInteractionEnabled = true
        }
    }
}

// MARK: - UITextFieldDelegate Extension

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == statusTextField {
            statusText = textField.text ?? "No status set"
            statusLabel.text = statusText
        }
    }
}
