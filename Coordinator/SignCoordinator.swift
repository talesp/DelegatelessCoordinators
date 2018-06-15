//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class SignCoordinator: Coordinator {

    override func start(with completion: @escaping () -> Void) {

        let signViewController = SignViewController()

        if let navigationController = self.rootViewController as? UINavigationController {
            navigationController.pushViewController(signViewController, animated: true)
        }
        else if let tabBarController = self.rootViewController as? UITabBarController {
            tabBarController.viewControllers?.append(signViewController)
        }
        signViewController.parentCoordinator = self
        super.start(with: completion)
    }

}
