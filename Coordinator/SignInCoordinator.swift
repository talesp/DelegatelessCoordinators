//
// Created by Tales Pinheiro De Andrade on 02/06/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit
enum SignInEventType: AppEventType {
    typealias Username = String
    typealias Password = String
    case signIn(Username, Password)
    case emptyUsernameOrPassword
}

class SignInEvent: AppEvent {
    private(set) var type: AppEventType
    private(set) var subtype: AppEventSubType? = nil

    init(type: SignInEventType, subtype: AppEventSubType? = nil) {
        self.type = type
        self.subtype = subtype
    }
}

class SignInCoordinator: Coordinator {

    override func start(with completion: @escaping () -> Void) {
        let viewController = SignInViewController()
        viewController.parentCoordinator = self
        guard let navigationController = self.rootViewController as? UINavigationController else { return }
        navigationController.pushViewController(viewController, animated: true)
        super.start(with: completion)
    }
}
