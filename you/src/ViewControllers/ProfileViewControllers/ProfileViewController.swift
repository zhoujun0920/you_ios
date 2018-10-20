//
//  ProfileViewController.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import CoreStore

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 194
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: ProfileImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "profileImageCell") as! ProfileImageTableViewCell
            cell.currentVC = self
            return cell
        } else if indexPath.section == 1{
            let cell: ProfileInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "profileInfoCell") as! ProfileInfoTableViewCell
            return cell
        } else {
            let cell: LogOutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "logOutCell") as! LogOutTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default, handler: {
                action in
                _ = try? Static.youStack.perform(
                    synchronous: { (transaction) in
                        transaction.deleteAll(From<User>())
                        self.dismiss(animated: true, completion: nil)
                })
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(yes)
            self.present(alert, animated: true, completion: nil)
        }
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
