//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class TabCoordinator: Coordinator {

    override func startChild(coordinator: CoordinatorProtocol, completion: @escaping () -> Void = {}) {
        guard let tabBarController = self.rootViewController as? UITabBarController else { return }
        tabBarController.viewControllers = tabBarController.viewControllers ?? []
        assert((tabBarController.viewControllers?.count ?? 0) < 4, "`UITabBarController`s support a maximum of 5 " +
                                                                   "controllers")
        super.startChild(coordinator: coordinator, completion: completion)
    }
}
