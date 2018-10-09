//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit
import os.log

class AppCoordinator: Coordinator {
    private var window: UIWindow
    private var navigationCoordinator: NavigationCoordinator?

    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: nil)
    }

    override func start(with completion: @escaping () -> Void = {}) {

        if let _ = UserDefaults.standard.string(forKey: "user") {
            let tabBarCoordinator = setupTabCoordinator()
            self.startChild(coordinator: tabBarCoordinator)
        }
        else {
            self.navigationCoordinator = setupNavigationCoordinator()
            self.startChild(coordinator: self.navigationCoordinator!)
        }

        self.window.makeKeyAndVisible()

        self.add(event: SignEvent.self) { [weak self] event in
            switch event {
            case .signIn:
                guard let navigationCoordinator = self?.navigationCoordinator else {
                    fatalError("something went wrong")
                }
                let childCoordinator = SignInCoordinator(rootViewController: navigationCoordinator.rootViewController)
                navigationCoordinator.startChild(coordinator: childCoordinator)
            case .signUp:
                let alertController = UIAlertController(title: nil,
                                                        message: "Currently it impossible to sign up in the app, please go to the site :p",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self?.rootViewController?.present(alertController, animated: true)
            }
        }

        self.add(event: SignInEvent.self) { [weak self] event in
            switch event {
            case .emptyUsernameOrPassword:
                let alertController = UIAlertController(title: "Error",
                                                        message: "Empty or invalid username or password",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self?.rootViewController?.present(alertController, animated: true)

            case let .signIn(username, password):
                print("Auth with Username: \(username) - password: \(password)")
                guard let navigationCoordinator = self?.navigationCoordinator else {
                    fatalError("super.handle(event: event, withSender: self)")
                }

                self?.stopChild(coordinator: navigationCoordinator)

                guard let tabBarCoordinator = self?.setupTabCoordinator() else { return }
                self?.startChild(coordinator: tabBarCoordinator)
            }
        }
        super.start(with: completion)
    }

    private func setupNavigationCoordinator() -> NavigationCoordinator {
        let navigationController = UINavigationController()
        self.rootViewController = navigationController
        self.window.rootViewController = self.rootViewController

        let navigationCoordinator = NavigationCoordinator(rootViewController: navigationController)
        navigationCoordinator.startChild(coordinator: SignCoordinator(rootViewController: navigationController))
        return navigationCoordinator
    }

    private func setupTabCoordinator() -> TabCoordinator {
        let tabBarController = UITabBarController()
        self.rootViewController = tabBarController
        self.window.rootViewController = self.rootViewController

        let productListCoordinator = ProductListCoordinator(rootViewController: tabBarController)
        let shoppingCartCoordinator = ShoppingCartCoordinator(rootViewController: tabBarController)
        let profileCoordinator = ProfileCoordinator(rootViewController: tabBarController)

        let tabBarCoordinator = TabCoordinator(rootViewController: tabBarController)
        tabBarCoordinator.startChild(coordinator: productListCoordinator)
        tabBarCoordinator.startChild(coordinator: shoppingCartCoordinator)
        tabBarCoordinator.startChild(coordinator: profileCoordinator)
        return tabBarCoordinator
    }

}
