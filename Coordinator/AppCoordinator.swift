//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit
import os.log

class AppCoordinator: Coordinator {
    private var window: UIWindow
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
            let navigationCoordinator = setupNavigationCoordinator()
            self.startChild(coordinator: navigationCoordinator)
        }

        self.window.makeKeyAndVisible()

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

    override func canHandle(event: AppEvent, withSender sender: Any?) -> Bool {
        switch event.type {
        case SignEventType.signIn,
             SignInEventType.signIn,
             SignInEventType.emptyUsernameOrPassword:
            return true
        default:
            return super.canHandle(event: event, withSender: sender)
        }
    }

    override func handle(event: AppEvent, withSender sender: Any?) {
        switch event.type {
            case SignEventType.signIn:
                guard let navigationCoordinator = self.childCoordinators["NavigationCoordinator"] as?
                NavigationCoordinator else { super.handle(event: event, withSender: sender); return }
                navigationCoordinator.startChild(coordinator: SignInCoordinator(rootViewController:
                                                                                navigationCoordinator.rootViewController))
        case SignInEventType.emptyUsernameOrPassword:
            let alertController = UIAlertController(title: "Error",
                                                    message: "Empty or invalid username or password",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.rootViewController?.present(alertController, animated: true)
            
        case let SignInEventType.signIn(username, password):
            print("Auth with Username: \(username) - password: \(password)")
            guard let navigationCoordinator = self.childCoordinators["NavigationCoordinator"] as?
                    NavigationCoordinator else { super.handle(event: event, withSender: sender); return }
            self.stopChild(coordinator: navigationCoordinator)

            let tabBarCoordinator = setupTabCoordinator()
            self.startChild(coordinator: tabBarCoordinator)

        default:
            super.handle(event: event, withSender: sender)
        }

    }
}
