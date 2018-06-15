//
// Created by Tales Pinheiro De Andrade on 02/06/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Shopping Cart"

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
    }
}
