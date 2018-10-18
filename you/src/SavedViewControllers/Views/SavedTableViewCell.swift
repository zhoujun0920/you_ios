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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.savedCollectionView.dataSource = self
        self.savedCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SavedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SavedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCollectionViewCell", for: indexPath) as! SavedCollectionViewCell
        cell.updateCollectionView()
        return cell
    }
    
    
}
