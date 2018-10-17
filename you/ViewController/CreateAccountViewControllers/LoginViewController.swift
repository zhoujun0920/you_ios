//
//  LoginViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: DTTextField!
    @IBOutlet weak var passwordTextField: DTTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.isSecureTextEntry = true
        if #available(iOS 10, *) {
            self.passwordTextField.textContentType = UITextContentType(rawValue: "")
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
    }
    
    

}
