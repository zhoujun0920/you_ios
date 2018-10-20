//
//  LoginViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import CoreStore

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: DTTextField!
    @IBOutlet weak var passwordTextField: DTTextField!
    
    var handle: AuthStateDidChangeListenerHandle!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.isSecureTextEntry = true
        if #available(iOS 10, *) {
            self.passwordTextField.textContentType = UITextContentType(rawValue: "")
        }
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(backgroundTapped(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backBtn = UIBarButtonItem(image: UIImage(named: "Back_Arrow")!,
                                      style: .plain, target: self, action: #selector(popSelf))
        self.navigationItem.leftBarButtonItem = backBtn
        self.handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
        self.ref = Database.database().reference()
        self.emailTextField.text = "test@test.com"
        self.passwordTextField.text = "Aa1234567&"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(self.handle!)
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        self.login()
    }
    
    func login() {
        self.view.addSubview(self.pleaseWaitIndicator)
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            super.alertErrorMessage(message: "Invalid email address or password.")
            self.pleaseWaitIndicator.removeFromSuperview()
            return
        }
        if email.isEmptyStr || password.isEmptyStr {
            super.alertErrorMessage(message: "Invalid email address or password.")
            self.pleaseWaitIndicator.removeFromSuperview()
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let user = user {
                print("login successful!")
                self.pleaseWaitIndicator.removeFromSuperview()
                let uid = user.user.uid
                self.ref.child("users").child(uid).observeSingleEvent(of: .value, with: {
                    snapshot in
                    if let value = snapshot.value {
                        let user = JSON(value)
                        self.saveUser(json: user, uid: uid)
                    }
                })
                return
            }
            if let error = error {
                self.pleaseWaitIndicator.removeFromSuperview()
                super.alertErrorMessage(message: error.localizedDescription)
                return
            }
            super.alertErrorMessage(message: "User not found.")
        }
    }
    
    func saveUser(json: JSON, uid: String) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From<User>())
                let user = transaction.create(Into<User>())
                user.fromJSON(json, keyValue: uid)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.currentUser = user
                super.goToMain()
        })
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.login()
        return true
    }
}
