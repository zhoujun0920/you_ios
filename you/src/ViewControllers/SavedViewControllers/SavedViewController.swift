//
//  SavedViewController.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class SavedViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return cell
    }
    
    
}
