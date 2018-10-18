//
//  SavedCollectionViewCell.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makeAppointmentButton: UIButton!
    
    func updateCollectionView() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.makeAppointmentButton.layer.cornerRadius = 5
    }
}
