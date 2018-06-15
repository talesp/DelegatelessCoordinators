//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class ProductListCoordinator: Coordinator {

    private var navigationController: UINavigationController?

    override func start(with completion: @escaping () -> Void = {}) {
        let productListViewController = ProductListViewController()

        let navigationController = UINavigationController(rootViewController: productListViewController)
        self.navigationController = navigationController

        if let tabBarController = self.rootViewController as? UITabBarController {
            if tabBarController.viewControllers == nil {
                tabBarController.viewControllers = [navigationController]
            }
            else {
                tabBarController.viewControllers?.append(navigationController)
            }
        }
        else {
            fatalError(String(describing: type(of: self.rootViewController)))
        }

        super.start(with: completion)
    }
}
