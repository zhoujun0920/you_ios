//
//  ForgotPasswordViewController.swift
//  you
//
//  Created by Jun Zhou on 10/23/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var emailTextField: DTTextField!
    @IBOutlet weak var oldPasswordTextField: DTTextField!
    @IBOutlet weak var newPasswordTextField: DTTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(image: UIImage(named: "Back_Arrow")!,
                                      style: .plain, target: self, action: #selector(popSelf))
        self.navigationItem.leftBarButtonItem = backBtn
        emailTextField.text = "test@test.com"
        newPasswordTextField.text = "Aa1234567&"
        // Do any additional setup after loading the view.
    }
  
    @IBAction func tapUpdate(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: oldPasswordTextField.text ?? "") {
            (result, error) in
            print(error?.localizedDescription)
            let credential = EmailAuthProvider.credential(withEmail: self.emailTextField.text ?? "",
                                                          password: self.oldPasswordTextField.text ?? "")
            if let currentUser = Auth.auth().currentUser {
                currentUser.reauthenticateAndRetrieveData(with: credential) {
                    (result, error) in
                    print(result.coreStoreDumpString)
                    print(error.coreStoreDumpString)
                    currentUser.updatePassword(to: self.newPasswordTextField.text ?? "Aa1234567&", completion: {
                        (error) in
                        
                        self.popSelf()
                        print(error.coreStoreDumpString)
                    })
                }
            }
        }
        
    }
}
