//
//  tableViewCellTableViewCell.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

   class tableViewCellTableViewCell: UITableViewCell {
    
    
    var tableIndexPath : IndexPath!
     // OUTLETS
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var watchCollectionView: UICollectionView!
    @IBOutlet weak var minimizeButton: UIButton!
    
    
    override func awakeFromNib() {
    super.awakeFromNib()
     
    // SETTING UP THE FLOW LAYOUT
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 120, height: 120)
    flowLayout.minimumInteritemSpacing = 5
    flowLayout.scrollDirection = .horizontal
    watchCollectionView.collectionViewLayout = flowLayout
        
    // CREATING THE NIB OF THE COLLECTION VIEW CELL
    let nibOfCollCell = UINib( nibName : "ImageCollectionViewCell" , bundle : nil)
        
    // REGISTERING THE NIB OF THE COLLECTION VIEW CELL
    watchCollectionView.register(nibOfCollCell, forCellWithReuseIdentifier: "ImageCollectionViewCellID")
    }
    
    override func prepareForReuse() {
        
        watchCollectionView.reloadData()
    }

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}






