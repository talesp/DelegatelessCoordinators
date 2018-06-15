//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

extension  UIViewController {

    private struct AssociatedKeys {
        static var ParentCoordinator = "ParentCoordinator"
    }

    weak var parentCoordinator: CoordinatorProtocol? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ParentCoordinator) as? CoordinatorProtocol
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ParentCoordinator, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
