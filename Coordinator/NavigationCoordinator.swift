//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

public class NavigationCoordinator: Coordinator {

    override public func start(with completion: @escaping () -> Void) {
        guard let rootViewController = self.rootViewController as? UINavigationController else { return }
        rootViewController.delegate = self
        super.start(with: completion)
    }

    override public func stop(with completion: @escaping () -> Void) {
        guard let rootViewController = self.rootViewController as? UINavigationController else { return }
        rootViewController.delegate = nil
        super.stop(with: completion)
    }
}

extension NavigationCoordinator: UINavigationControllerDelegate {

}
