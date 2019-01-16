//
//  SavedTableViewCell.swift
//  you
//
//  Created by Jun Zhou on 10/17/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet weak var savedCollectionView: UICollectionView!
    var superUsers = [SuperUser]()
    var currentVC: SavedViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.savedCollectionView.dataSource = self
        self.savedCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(superUsers: [SuperUser], currentVC: SavedViewController) {
        self.currentVC = currentVC
        self.superUsers = superUsers
        self.savedCollectionView.reloadData()
    }
}

extension SavedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.superUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SavedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCollectionViewCell", for: indexPath) as! SavedCollectionViewCell
        let superUser = self.superUsers[indexPath.row]
        cell.updateCollectionView(superUser: superUser, currentVC: self.currentVC)
        return cell
    }
}
