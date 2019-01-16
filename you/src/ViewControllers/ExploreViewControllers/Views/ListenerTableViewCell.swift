//
//  ListenerTableViewCell.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class ListenerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listenerNameLabel: UILabel!
    @IBOutlet weak var listenerDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(superUser: SuperUser) {
        self.listenerNameLabel.text = superUser.nickName
    }

}
