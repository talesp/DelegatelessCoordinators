//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {

    private var profileViewController: ProfileViewController?

    override func start(with completion: @escaping () -> Void = {}) {
        let profileViewController = ProfileViewController()

        if let tabBarController = self.rootViewController as? UITabBarController {
            if tabBarController.viewControllers == nil {
                tabBarController.viewControllers = [profileViewController]
            }
            else {
                tabBarController.viewControllers?.append(profileViewController)
            }
        }
        else {
            fatalError(String(describing: type(of: self.rootViewController)))
        }

        super.start(with: completion)
    }
}
