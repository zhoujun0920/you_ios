//
//  ViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var pleaseWaitIndicator: ProgressIndicator!
    var loadingIndicator: ProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.pleaseWaitIndicator = ProgressIndicator(text: "Please wait...")
        self.loadingIndicator = ProgressIndicator(text: "Loading...")
    }
    
    @objc func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertErrorMessage(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "error title"), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToMain() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let tabViewController
            = mainStoryBoard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            self.present(tabViewController, animated: true, completion: nil)
        }
    }
}

