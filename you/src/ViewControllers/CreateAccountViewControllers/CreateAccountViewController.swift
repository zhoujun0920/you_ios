//
//  CreateAccountViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import CoreStore

class CreateAccountViewController: BaseViewController {
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAccountButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        guard let user = Static.youStack.fetchAll(From(User.self)) else {
            return
        }
        if !user.isEmpty {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.currentUser = user.first
            super.goToMain()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func createAccount(_ sender: UIButton) {
        print("create a new account, go to user info.")
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From<User>())
        })
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("login directly")
    }

}
