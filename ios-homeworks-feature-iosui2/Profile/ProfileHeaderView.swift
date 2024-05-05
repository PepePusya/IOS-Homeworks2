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
    
    // MARK: - Setup section
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        fullNameLabel.text = "Pepe cat"
        fullNameLabel.font = .boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        addSubview(fullNameLabel)

        statusLabel.text = statusText
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textColor = .black
        addSubview(statusLabel)

        statusTextField.textColor = .darkGray
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 8
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.gray.cgColor
        statusTextField.attributedPlaceholder = NSAttributedString(string: "Ready...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        statusTextField.leftViewMode = .always
        addSubview(statusTextField)

        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 8
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        addSubview(setStatusButton)

        avatarImageView.image = UIImage(named: "avatarImage")
        avatarImageView.layer.cornerRadius = 64
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        addSubview(avatarImageView)

        returnAvatarButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        returnAvatarButton.tintColor = .black
        addSubview(returnAvatarButton)

        avatarBackground.backgroundColor = .darkGray.withAlphaComponent(0.7)
        avatarBackground.isHidden = true
        addSubview(avatarBackground)
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(128)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(28)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(fullNameLabel)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(fullNameLabel)
            make.height.equalTo(32)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(fullNameLabel)
            make.height.equalTo(48)
        }
        
        returnAvatarButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(40)
        }

        avatarBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
