//
//  MessageNavigationController.swift
//  you
//
//  Created by Jun Zhou on 10/22/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class MessageNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = NewMessageController()
        self.setViewControllers([vc], animated: true)
        // Do any additional setup after loading the view.
    }

}
