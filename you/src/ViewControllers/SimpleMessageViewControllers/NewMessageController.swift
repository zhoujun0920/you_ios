//
//  NewMessageController.swift
//  gameofchats
//
//  Created by Brian Voong on 6/29/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import Firebase
import CoreStore
import SwiftyJSON

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        fetchFriends()
        watchFriends()
    }
 
    func fetchFriends() {
        if let currentUser = Auth.auth().currentUser {
            Database.database().reference().child("users").child(currentUser.uid).child("friends").observeSingleEvent(of: .value, with: {
                snapshot in
                if let value = snapshot.value {
                    let jsons = JSON(value)
                    self.saveFriends(jsons: jsons)
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
            }, withCancel: {
                error in
                print(error.localizedDescription)
            })
        }
    }
    
    func saveFriends(jsons: JSON) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From(Friend.self))
                for json in jsons.arrayValue {
                    let friend = transaction.create(Into<Friend>())
                    friend.fromJSON(json)
                }
        })
        if let friends = Static.youStack.fetchAll(From(Friend.self)) {
            self.friends = friends.sorted(by: {
                if let n0 = $0.nickName, let n1 = $1.nickName {
                    return n0 < n1
                }
                return true
            })
        }
    }
    
    func watchFriends() {
        if let currentUser = Auth.auth().currentUser {
            Database.database().reference().child("users").child(currentUser.uid).child("friends").observe(.childAdded, with: {
                snapshot in
                if let value = snapshot.value {
                    let json = JSON(value)
                    self.addFriend(json: json)
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                }
            }, withCancel: {
                error in
                print(error.localizedDescription)
            })
            
        }
    }
    
    func addFriend(json: JSON) {
        _ = try? Static.youStack.perform(
            synchronous: { (transaction) in
                transaction.deleteAll(From(Friend.self))
                let friend = transaction.create(Into<Friend>())
                friend.fromJSON(json)
                self.friends.append(friend)
                self.friends.sorted(by: {
                    if let n0 = $0.nickName, let n1 = $1.nickName {
                        return n0 < n1
                    }
                    return true
                })
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let user = friends[indexPath.row]
        cell.textLabel?.text = user.nickName
        
        if let profileImageUrl = user.photoUrl {
            cell.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: MessagesController!

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = self.friends[indexPath.row]
        let messagesController = MessagesController()
        messagesController.showChatControllerForUser(friend, navigationController: self.navigationController)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}








