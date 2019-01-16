//
//  SavedViewController.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import CoreStore

class SavedViewController: BaseViewController {
    
    @IBOutlet weak var savedTableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    var superUsers = [SuperUser]()
    var listeners = [SuperUser]()
    var consultants = [SuperUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.savedTableView.addSubview(self.refreshControl)
        fetchSuperUsers()
        //watchSuperUsers()
    }
    
    func fetchSuperUsers() {
        if let currentUser = Auth.auth().currentUser {
            Database.database().reference().child("users").child(currentUser.uid).child("super-users").observeSingleEvent(of: .value, with: {
                snapshot in
                if let value = snapshot.value {
                    let superUsers = JSON(value)
                    self.saveSuperUsers(jsons: superUsers)
                }
                self.savedTableView.reloadData()
                self.refreshControl.endRefreshing()
            }) { (error) in
                print(error.localizedDescription)
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func watchSuperUsers() {
        if let currentUser = Auth.auth().currentUser {
            Database.database().reference().child("users").child(currentUser.uid).child("super-users").observe(.childAdded, with: {
                snapshot in
                if let value = snapshot.value {
                    let json = JSON(value)
                    self.addSuperUser(json: json)
                }
                self.savedTableView.reloadData()
            }, withCancel: {
                error in
                print(error.localizedDescription)
            })
        }
    }
    
    func addSuperUser(json: JSON) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From<SuperUser>())
                let superUser = transaction.create(Into<SuperUser>())
                superUser.fromJSON(json)
                if let role = superUser.role {
                    if role == "CONSULTANT" {
                        self.consultants.append(superUser)
                    } else {
                        self.listeners.append(superUser)
                    }
                }
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchSuperUsers()
    }
    
    func saveSuperUsers(jsons: JSON) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From<SuperUser>())
                for json in jsons.arrayValue {
                    let superUser = transaction.create(Into<SuperUser>())
                    superUser.fromJSON(json)
                }
        })
        if let superUsers = Static.youStack.fetchAll(From(SuperUser.self)) {
            self.superUsers = superUsers
        }
        if let listeners = Static.youStack.fetchAll(From<SuperUser>().where(\.role == "LISTENER")) {
            self.listeners = listeners
        }
        if let consultants = Static.youStack.fetchAll(From<SuperUser>().where(\.role == "CONSULTANT")) {
            self.consultants = consultants
        }
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Listener"
        }
        return "Consultant"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SavedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "savedTableViewCell") as! SavedTableViewCell
        if indexPath.section == 0 {
            cell.updateView(superUsers: self.listeners, currentVC: self)
        } else {
            cell.updateView(superUsers: self.consultants, currentVC: self)
        }
        return cell
    }
}
