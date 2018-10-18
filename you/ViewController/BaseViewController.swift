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
        self.progressIndicator = ProressIndicator(text: "Please wait...")
    }
    
    @objc func popSelf() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToLogin() {
        let homeStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let homeNavigationViewController
            = homeStoryBoard.instantiateViewController(withIdentifier: "MainNavigationViewController") as? UINavigationController {
            self.present(homeNavigationViewController, animated: true, completion: nil)
        }
    }
}

