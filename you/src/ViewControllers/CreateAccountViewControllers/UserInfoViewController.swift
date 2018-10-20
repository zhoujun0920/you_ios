//
//  UserInfoViewController.swift
//  you
//
//  Created by Jun Zhou on 10/16/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import CoreStore

class UserInfoViewController: CreateAccountBaseViewController {
    
    @IBOutlet weak var fullNameTextField: DTTextField!
    @IBOutlet weak var nickNameTextField: DTTextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!

    var birthDate: NSDate?
    var isBlocked = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullNameTextField.autocorrectionType = .no
        self.nickNameTextField.autocorrectionType = .no
        self.fullNameTextField.delegate = self
        self.nickNameTextField.delegate = self
        self.birthDateTextField.delegate = self
        self.fullNameTextField.addTarget(self,
                                          action: #selector(textFieldDidChange(_:)),
                                          for: .editingChanged)
        self.nickNameTextField.addTarget(self,
                                         action: #selector(textFieldDidChange(_:)),
                                         for: .editingChanged)
        self.birthDatePicker.addTarget(self,
                                       action: #selector(datePickerChanged(_:)),
                                       for: .valueChanged)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(backgroundTapped(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.changeNextButton(checkIsBlocked())
        
        self.fullNameTextField.text = "Jun"
        self.nickNameTextField.text = "Jun"
        self.birthDatePicker.date = Date()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        super.changeNextButton(checkIsBlocked())
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.hideBirthDatePicker()
    }
    
    @objc func datePickerChanged(_ datePicker: UIDatePicker) {
        super.changeNextButton(checkIsBlocked())
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        self.birthDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.birthDate = NSDate(timeIntervalSince1970: datePicker.date.timeIntervalSince1970)
    }
    
    func showBirthDatePicker() {
        UIView.animate(withDuration: 0.5, animations: {
            self.birthDatePicker.center.y = self.view.frame.maxY - 108
            super.datePickerDidShow()
        })
    }
    
    func hideBirthDatePicker() {
        if !self.isPickerHide {
            UIView.animate(withDuration: 0.5, animations: {
                self.birthDatePicker.center.y = self.view.frame.maxY + 108
                super.datePickerDidHide()
            })
        }
    }

    func checkIsBlocked() -> Bool {
        guard let fullName = self.fullNameTextField.text,
            let nickName = self.nickNameTextField.text,
            let birthDate = self.birthDateTextField.text else {
            return true
        }
        if (!fullName.isEmptyStr && !nickName.isEmptyStr && !birthDate.isEmptyStr) {
            
            return false
        }
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !checkIsBlocked()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEmailPasswordVC" {
            if segue.destination is EmailPasswordViewController {
                _ = try? Static.youStack.perform(
                    synchronous: { (transaction) in
                        let user = transaction.create(Into<User>())
                        user.name = self.fullNameTextField.text
                        user.nickName = self.nickNameTextField.text
                        user.birthDate = self.birthDatePicker.date as NSDate
                })
            }
        }
    }
    
    override func popSelf() {
        super.popSelf()
    }
}


extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideBirthDatePicker()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 3 {
            self.birthDatePicker.isHidden = false
            self.view.endEditing(true)
            self.showBirthDatePicker()
            return false
        }
        self.hideBirthDatePicker()
        return true
    }
}

