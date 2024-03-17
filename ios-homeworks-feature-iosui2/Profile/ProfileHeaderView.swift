import UIKit

class ProfileHeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatarImage"))
        imageView.layer.cornerRadius = 50.0
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
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
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
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
        textField.backgroundColor = .white
        textField.placeholder = "Input Text"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.textColor = .black
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12.0
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        
        let leftPaddingView = UIView(frame:CGRect(x: 0, y: 0, width: 8.0, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        addGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(overlayView)
        addSubview(avatarImageView)
        addSubview(closeButton)
        addSubview(setStatusButton)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        
        
        _ = self.safeAreaLayoutGuide
        
        
        bringSubviewToFront(avatarImageView)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100.0),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
                                                 
                                                 fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0),
                                                 
                                                 
                                                 statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4.0),
                                                 statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
                                                 
                                                 
                                                 setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant:  12.0),
                                                 setStatusButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
                                                 setStatusButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
                                                 setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
                                                 
                                                 statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8.0),
                                                 
                                                 statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0),
                                                 statusTextField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
                                                 statusTextField.heightAnchor.constraint(equalToConstant: 40.0)
                                    ])
        
        setStatusButton.addTarget(self, action: #selector(setStatusButtonTapped), for: .touchUpInside)
    }
    @objc private func setStatusButtonTapped() {
        statusLabel.text = statusTextField.text
    }
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.addGestureRecognizer(tapGesture)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func avatarTapped() {
        
        guard let superview = self.superview else { return }
        
        
        let targetWidth = superview.bounds.width
        let scaleRatio = targetWidth / avatarImageView.bounds.width
        
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.avatarImageView.transform = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
            
            
            self.avatarImageView.center = CGPoint(x: superview.bounds.midX, y: superview.bounds.midY)
            
            
            self.avatarImageView.layer.cornerRadius = 0
            
            
            self.overlayView.alpha = 1
            self.overlayView.frame = superview.bounds
            
            
            self.closeButton.alpha = 1
        })
    }
    
    @objc private func closeButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.closeButton.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                
                self.avatarImageView.transform = .identity
                self.avatarImageView.layer.cornerRadius = 50.0
                self.avatarImageView.frame = CGRect(x: 16.0, y: 16.0, width: 100.0, height: 100.0)
                
                self.overlayView.alpha = 0
            })
        }
    }
}
