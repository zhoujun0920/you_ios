//
//  CreateAccountBaseViewController.swift
//  you
//
//  Created by Jun Zhou on 10/16/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class CreateAccountBaseViewController: BaseViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonToBottomConstraint: NSLayoutConstraint!
    
    var isPickerHide: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.layer.cornerRadius = 5;
        let backBtn = UIBarButtonItem(image: UIImage(named: "Back_Arrow")!,
                                      style: .plain, target: self, action: #selector(popSelf))
        self.navigationItem.leftBarButtonItem = backBtn
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardDidShow(_:)),
                                               name: UIResponder.keyboardDidShowNotification , object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardDidHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification , object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardDidHideNotification,
                                                  object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToHome() {
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        if let homeNavigationViewController
            = homeStoryBoard.instantiateViewController(withIdentifier: "LoginNavigationViewController") as? UINavigationController {
            self.present(homeNavigationViewController, animated: true, completion: nil)
        }
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        print("Keyboard will show!")
        let keyboardSize:CGSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
            as! NSValue).cgRectValue.size
        print("Keyboard size: \(keyboardSize)")
        let height = min(keyboardSize.height, keyboardSize.width)
        guard self.nextButtonToBottomConstraint != nil else {
            return
        }
        if self.isPickerHide {
            self.nextButtonToBottomConstraint.constant = height +  20
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardDidHide(_ notification: NSNotification) {
        print("Keyboard will hide!")
        guard self.nextButtonToBottomConstraint != nil else {
            return
        }
        if self.isPickerHide {
            self.nextButtonToBottomConstraint.constant = 20
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func datePickerDidShow() {
        self.isPickerHide = false
        guard self.nextButtonToBottomConstraint != nil else {
            return
        }
        self.nextButtonToBottomConstraint.constant = 216 + 20
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func datePickerDidHide() {
        self.isPickerHide = true
        guard self.nextButtonToBottomConstraint != nil else {
            return
        }
        self.nextButtonToBottomConstraint.constant = 20
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func changeNextButton(_ isBlocked: Bool) {
        if isBlocked {
            self.nextButton.titleLabel?.textColor = UIColor.black
        } else {
            self.nextButton.titleLabel?.textColor = UIColor.black
        }
    }
}
