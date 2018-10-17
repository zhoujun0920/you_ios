//
//  EnableNotificationLocationViewController.swift
//  you
//
//  Created by Jun Zhou on 10/15/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import UserNotifications

class EnableNotificationLocationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openNotificationSetting(_ sender: UIButton) {
         
    }
    
    @IBAction func openLocationSetting(_ sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
            if granted {
               UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
    }
    
    @IBAction func skip(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.alertCreateSucceed()
        }
    }
    
    func alertCreateSucceed() {
        let alert = UIAlertController(title: "Create Succeed", message: "You Y.O.U account is ready. Please login.", preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            super.goToLogin()
        })
        alert.addAction(positiveAction)
        present(alert, animated: true, completion: nil)
    }

}
