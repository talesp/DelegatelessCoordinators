//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class NavigationCoordinator: Coordinator {

    init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
    }

    override func start(with completion: @escaping () -> Void) {
        guard let rootViewController = self.rootViewController as? UINavigationController else { return }
        rootViewController.delegate = self
        super.start(with: completion)
    }

    override func stop(with completion: @escaping () -> Void) {
        guard let rootViewController = self.rootViewController as? UINavigationController else { return }
        rootViewController.delegate = nil
        super.stop(with: completion)
    }
}

extension NavigationCoordinator: UINavigationControllerDelegate {

}