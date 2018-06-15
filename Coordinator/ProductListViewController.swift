//
// Created by Tales Pinheiro De Andrade on 31/05/18.
// Copyright (c) 2018 talesp. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Product List"

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
    }

}
