//
//  ViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var progressIndicator: ProressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let backBtn = UIBarButtonItem(image: UIImage(named: "Back_Arrow")!,
                                      style: .plain, target: self, action: #selector(popSelf))
        self.navigationItem.leftBarButtonItem = backBtn
        self.progressIndicator = ProressIndicator(text: "Please wait...")
    }

    func alertErrorMessage(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "error title"), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToHome() {
        let homeStoryBoard = UIStoryboard(name: "Home", bundle: nil)
        if let homeNavigationViewController
            = homeStoryBoard.instantiateViewController(withIdentifier: "LoginNavigationViewController") as? UINavigationController {
            self.present(homeNavigationViewController, animated: true, completion: nil)
        }
    }
    
    func goToLogin() {
        let homeStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let homeNavigationViewController
            = homeStoryBoard.instantiateViewController(withIdentifier: "MainNavigationViewController") as? UINavigationController {
            self.present(homeNavigationViewController, animated: true, completion: nil)
        }
    }
}

