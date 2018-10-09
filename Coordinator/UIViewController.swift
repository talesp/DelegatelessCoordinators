//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

extension UIViewController {

    private struct AssociatedKeys {
        static var ParentCoordinator = "ParentCoordinator"
    }

    weak var parentCoordinator: Coordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ParentCoordinator) as? Coordinator
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ParentCoordinator, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
