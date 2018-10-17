//
//  EmailPasswordViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class EmailPasswordViewController: CreateAccountBaseViewController {
    
    @IBOutlet weak var emailAddressTextField: DTTextField!
    @IBOutlet weak var passwordTextField: DTTextField!
    @IBOutlet weak var specialCharacterErrorLabel: UILabel!
    @IBOutlet weak var uppercaseErrorLabel: UILabel!
    @IBOutlet weak var lowercaseErrorLabel: UILabel!
    @IBOutlet weak var characterNumberErrorLabel: UILabel!
    @IBOutlet weak var emailAddressErrorLabel: UILabel!
    
    var emailAddress: String?
    var showPassword = false
    var isBlocked = true
    var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        super.isPickerHide = true
        self.passwordTextField.autocorrectionType = .no
        self.passwordTextField.addTarget(self,
                                         action: #selector(textFieldDidChange(_:)),
                                         for: .editingChanged)
        self.emailAddressTextField.addTarget(self,
                                         action: #selector(textFieldDidChange(_:)),
                                         for: .editingChanged)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(backgroundTapped(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailAddressTextField.text = "test@test.com"
        self.passwordTextField.text = "Aa1234567&"
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func isCharacterNumberValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format:
            "SELF MATCHES %@", "^.{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    func isUppercaseValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format:
            "SELF MATCHES %@", ".*[A-Z]+.*")
        return passwordTest.evaluate(with: password)
    }
    
    func isLowercaseValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format:
            "SELF MATCHES %@", "^.*(?=.*[a-z]).*$")
        return passwordTest.evaluate(with: password)
    }
    
    func isSpecialCharacterValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format:
            "SELF MATCHES %@", "^.*(?=.*[!@#$&*]).*$")
        return passwordTest.evaluate(with: password)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1 {
            guard let emailAddress = self.emailAddressTextField.text else {
                return
            }
            if self.emailAddressErrorLabel.isHidden {
                self.emailAddressErrorLabel.isHidden = false
            }
            checkEmailIsBlocked(emailAddress: emailAddress)
        } else if textField.tag == 2 {
            guard let password = self.passwordTextField.text else {
                return
            }
            if self.characterNumberErrorLabel.isHidden {
                self.characterNumberErrorLabel.isHidden = false
                self.uppercaseErrorLabel.isHidden = false
                self.lowercaseErrorLabel.isHidden = false
                self.specialCharacterErrorLabel.isHidden = false
            }
            changeErrorStatus(password: password)
        }
    }
    
    func changeErrorStatus(password: String) {
        if self.isCharacterNumberValid(password) {
            self.isBlocked = false
            self.characterNumberErrorLabel.textColor = UIColor.FlatColor.Green.PasswordCorrectGreen
        } else {
            self.isBlocked = true
            self.characterNumberErrorLabel.textColor = UIColor.FlatColor.Red.PasswordErrorRed
        }
        if self.isUppercaseValid(password) {
            self.isBlocked = false
            self.uppercaseErrorLabel.textColor = UIColor.FlatColor.Green.PasswordCorrectGreen
        } else {
            self.isBlocked = true
            self.uppercaseErrorLabel.textColor = UIColor.FlatColor.Red.PasswordErrorRed
        }
        if self.isLowercaseValid(password) {
            self.isBlocked = false
            self.lowercaseErrorLabel.textColor = UIColor.FlatColor.Green.PasswordCorrectGreen
        } else {
            self.isBlocked = true
            self.lowercaseErrorLabel.textColor = UIColor.FlatColor.Red.PasswordErrorRed
        }
        if self.isSpecialCharacterValid(password) {
            self.isBlocked = false
            self.specialCharacterErrorLabel.textColor = UIColor.FlatColor.Green.PasswordCorrectGreen
        } else {
            self.isBlocked = true
            self.specialCharacterErrorLabel.textColor = UIColor.FlatColor.Red.PasswordErrorRed
        }
        if (self.isBlocked) {
            self.password = password
        }
        super.changeNextButton(self.isBlocked)
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        if self.showPassword {
            self.showPassword = false
            self.passwordTextField.isSecureTextEntry = true
        } else {
            self.showPassword = true
            self.passwordTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if !isBlocked {
            checkEnableNotification()
        }
    }
    
    func checkEmailIsBlocked(emailAddress: String) {
        if !emailAddress.isEmptyStr {
            if emailAddress.isValidEmail() {
                self.emailAddress = emailAddress
                self.isBlocked = false
                self.emailAddressErrorLabel.textColor = UIColor.FlatColor.Green.PasswordCorrectGreen
                return
            }
        }
        self.emailAddressErrorLabel.textColor = UIColor.FlatColor.Red.PasswordErrorRed
        self.isBlocked = true
    }
    
    func checkEnableNotification() {
//        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
//        if isRegisteredForRemoteNotifications {
            // User is registered for notification
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let tabViewController
            = mainStoryBoard.instantiateViewController(withIdentifier: "HomeTabBarController") as? UITabBarController {
            self.present(tabViewController, animated: true, completion: nil)
        }
//        } else {
//            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
//            if let enableNotificationViewController
//                = loginStoryBoard.instantiateViewController(withIdentifier: "EnableNotificationVC") as? UIViewController {
//                self.present(enableNotificationViewController, animated: true, completion: nil)
//            }
//        }
    }

}
