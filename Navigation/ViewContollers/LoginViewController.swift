//
//
// LoginViewController.swift
// Navigation]


import UIKit
import Combine
import Foundation


final class LoginViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var loginDelegate: LoginViewControllerDelegate? = LoginInspector()
    
    var userService: UserService = {
        let testUser = User(login: "testUser", fullName: "Test User", avatar: UIImage(named: "userAvatar")!, status: "Just testing")
        return CurrentUserService(user: testUser)
    }()
    
    private let passwordCracker = PasswordCracker()
    private var activityIndicator: UIActivityIndicatorView!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Visual content
    
    var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = LayoutConstants.cornerRadius
        stack.distribution = .fillProportionally
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        return stack
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let pixel = UIImage(named: "blue_pixel") {
            button.setBackgroundImage(pixel.image(alpha: 1), for: .normal)
            button.setBackgroundImage(pixel.image(alpha: 0.8), for: .selected)
            button.setBackgroundImage(pixel.image(alpha: 0.6), for: .highlighted)
            button.setBackgroundImage(pixel.image(alpha: 0.4), for: .disabled)
        }
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(touchLoginButton), for: .touchUpInside)
        button.layer.cornerRadius = LayoutConstants.cornerRadius
        button.clipsToBounds = true
        return button
    }()
    
    var loginField: UITextField = {
        let login = UITextField()
        login.translatesAutoresizingMaskIntoConstraints = false
        login.placeholder = "Log In"
        login.text = "correctLogin"
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.borderWidth = 0.25
        login.leftViewMode = .always
        login.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: login.frame.height))
        login.keyboardType = .emailAddress
        login.textColor = .black
        login.font = UIFont.systemFont(ofSize: 16)
        login.autocapitalizationType = .none
        login.returnKeyType = .done
        return login
    }()
    
    var passwordField: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leftViewMode = .always
        password.placeholder = "Password"
        password.text = "correctPassword"
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.isSecureTextEntry = false
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16)
        password.autocapitalizationType = .none
        password.returnKeyType = .done
        return password
    }()
    
    // MARK: - Setup section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        setupViews()
        setupConstraints()
        setupActivityIndicator()
        setupBruteForceButton()
        
        loginField.text = "correctLogin"
        passwordField.text = "correctPassword"
        
        startTimer()
    }
    
    private func setupViews() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        
        contentView.addSubviews(vkLogo, loginStackView, loginButton)
        
        loginStackView.addArrangedSubview(loginField)
        loginStackView.addArrangedSubview(passwordField)
        
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            
            loginStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),
            
            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutConstants.indent),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: -8)
        ])
    }
    
    private func setupBruteForceButton() {
        let bruteForceButton = UIButton(type: .system)
        bruteForceButton.setTitle("Подобрать пароль", for: .normal)
        bruteForceButton.addTarget(self, action: #selector(startBruteForce), for: .touchUpInside)
        bruteForceButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bruteForceButton)
        
        NSLayoutConstraint.activate([
            bruteForceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bruteForceButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func startTimer() {
        Timer.publish(every: 300, on: .main, in: .default) // 5 минут
            .autoconnect()
            .first()
            .sink { [weak self] _ in
                self?.showBreakReminder()
            }
            .store(in: &cancellables)
    }
    
    @objc private func showBreakReminder() {
        let alert = UIAlertController(title: "Перерыв", message: "Вы используете приложение уже 5 минут. Сделайте перерыв для глаз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func touchLoginButton() {
        do {
            try performLogin()
        } catch let error as LoginError {
            handleError(error)
        } catch {
            handleError(.unknownError)
        }
    }

    private func performLogin() throws {
        guard let login = loginField.text, !login.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            throw LoginError.emptyCredentials
        }
        
        userService.getUser(login: login) { [weak self] (result: Result<User, LoginError>) in
            switch result {
            case .success(let user):
                // Обязательное условие, без которого нет смысла продолжать выполнение
                guard user.login == login else {
                    preconditionFailure("User login must match the entered login")
                }
                // Если данные успешно загружены и проверка пройдена
                print("User loaded: \(user.fullName)")
                self?.coordinator?.showMainTabBar()
                
            case .failure(let error):
                // Обработка ошибки
                self?.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: LoginError) {
        let errorMessage: String
        switch error {
        case .emptyCredentials:
            errorMessage = "Please enter your login and password"
        case .invalidCredentials:
            errorMessage = "Invalid username or password"
        case .networkError:
            errorMessage = "Network error. Please try again."
        case .unknownError:
            errorMessage = "An unknown error occurred. Please try again."
        }
        
        showAlert(with: "Login Failed", message: errorMessage)
    }
    
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func startBruteForce() {
        loginButton.isEnabled = false  // Деактивируем кнопку
        activityIndicator.startAnimating()
        let fixedPassword = "correctPassword"  // Фиксированный пароль
        passwordField.isSecureTextEntry = false
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.passwordCracker.bruteForce(passwordToUnlock: fixedPassword) { foundPassword in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.passwordField.isSecureTextEntry = false
                    self?.passwordField.text = foundPassword
                    self?.showAlert(with: "Пароль найден", message: foundPassword)
                    self?.loginButton.isEnabled = true  // Активируем кнопку после завершения
                }
            }
        }
    }
}

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    
    // tap 'done'
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
