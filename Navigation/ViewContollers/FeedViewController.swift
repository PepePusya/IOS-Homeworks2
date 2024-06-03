// FeedViewController.swift
// Navigation

import UIKit

final class FeedViewController: UIViewController {

    private let viewModel = FeedViewModel()

    private lazy var guessTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your guess"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private lazy var checkGuessButton = CustomButton(title: "Check Guess", titleColor: .white) { [weak self] in
        self?.viewModel.checkGuess(self?.guessTextField.text)
    }

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        createSubView()
        bindViewModel()
    }
    
    private func createSubView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(guessTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -32)
        ])
        
        addPostButton(title: "Post number One", color: .systemPurple, to: stackView, selector: #selector(tapPostButton))
        addPostButton(title: "Post number Two", color: .systemIndigo, to: stackView, selector: #selector(tapPostButton))
    }
    
    private func addPostButton(title: String, color: UIColor, to view: UIStackView, selector: Selector) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.addTarget(self, action: selector, for: .touchUpInside)
        view.addArrangedSubview(button)
    }
    
    @objc func tapPostButton() {
        let post = postExamples[0]
        let postVC = PostViewController()
        postVC.post = post
        navigationController?.pushViewController(postVC, animated: true)
    }

    private func bindViewModel() {
        viewModel.resultText = { [weak self] text in
            self?.resultLabel.text = text
        }
        viewModel.resultColor = { [weak self] color in
            self?.resultLabel.textColor = color
        }
    }
}
