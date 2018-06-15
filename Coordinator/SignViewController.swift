//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

enum SignEventType: AppEventType {
    case signIn
    case signUp
}

struct SignEvent: AppEvent {
    private(set) var type: AppEventType
    private(set) var subtype: AppEventSubType? = nil
}

extension SignEvent {
    init(type: SignEventType, subtype: AppEventSubType? = nil) {
        self.type = type
        self.subtype = subtype
    }
}

class SignViewController: UIViewController {

    let signInButton = UIButton(type: .custom)
    let signUpButton = UIButton(type: .custom)
    lazy var stackView = UIStackView(arrangedSubviews: [self.signInButton, self.signUpButton])
    

    override func loadView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        self.view = stackView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInButton.setTitle("Sign in", for: .normal)
        self.signUpButton.setTitle("Sign up", for: .normal)

        self.signInButton.addTarget(self,
                                    action: #selector(signIn(sender:)),
                                    for: .touchUpInside)
    }

    @objc func signIn(sender: UIButton) {
        parentCoordinator?.handle(event: SignEvent(type: .signIn), withSender: self)
    }
}
