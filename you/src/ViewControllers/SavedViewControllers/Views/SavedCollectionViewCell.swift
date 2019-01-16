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
    var currentVC: SavedViewController!
    var superUser: SuperUser!
    
    func updateCollectionView(superUser: SuperUser, currentVC: SavedViewController) {
        self.currentVC = currentVC
        self.superUser = superUser
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.makeAppointmentButton.layer.cornerRadius = 5
        self.nameLabel.text = superUser.nickName
    }
    @IBAction func tapResearveButton(_ sender: Any) {
        let researveActionSheet = UIAlertController(title: superUser.nickName, message: nil, preferredStyle: .actionSheet)
        let reserve = UIAlertAction(title: "Researve", style: .default) {
            (action) in
            print("researve")
        }
        let facetimeNow = UIAlertAction(title: "Facetime Now", style: .default) {
            (action) in
            if let facetimeURL = URL(string: "facetime://6129998107") {
                if (UIApplication.shared.canOpenURL(facetimeURL)) {
                    if #available(iOS 10.0, *) {
                       UIApplication.shared.open(facetimeURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(facetimeURL)
                    }
                }
            }
        }
        let phoneCallNow = UIAlertAction(title: "Call Now", style: .default) {
            (action) in
            if let phoneCallURL = URL(string: "tel://6129998107") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(phoneCallURL)
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
            researveActionSheet.dismiss(animated: true, completion: nil)
        }
        researveActionSheet.addAction(reserve)
        researveActionSheet.addAction(facetimeNow)
        researveActionSheet.addAction(phoneCallNow)
        researveActionSheet.addAction(cancel)
        self.currentVC.present(researveActionSheet, animated: true, completion: nil)
    }
}
