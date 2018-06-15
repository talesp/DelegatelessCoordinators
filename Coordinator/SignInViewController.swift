//
// Created by Tales Pinheiro De Andrade on 02/06/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit


class SignInViewController: UIViewController {

    private lazy var passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.placeholder = "Password"
        return passwordField
    }()

    private lazy var usernameField: UITextField = {
        let usernameField = UITextField()
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.placeholder = "username"
        return usernameField
    }()

    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signIn(sender:)), for: .touchUpInside)
        signInButton.setTitleColor(.darkGray, for: .normal)
        return signInButton
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.usernameField,
            self.passwordField,
            self.signInButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
        return contentView
    }()

    override func loadView() {
        self.view = contentView
    }

    @objc func signIn(sender: UIButton) {
        guard let username = self.usernameField.text, username.isEmpty == false,
                let password = self.passwordField.text, password.isEmpty == false else {
            self.parentCoordinator?.handle(event: SignInEvent(type: .emptyUsernameOrPassword), withSender: self)
            return
        }
        self.parentCoordinator?.handle(event: SignInEvent(type: .signIn(username, password)), withSender: self)
    }
}
