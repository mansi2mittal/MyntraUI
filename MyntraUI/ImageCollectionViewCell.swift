//
//  ImageCollectionViewCell.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //
     var arrayOfSelectedItems = [UIImage]()
    
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        

        // Initialization code
    }
    
    func populateWithData(_ data: WatchModel)
    {
        imageInCell.image = data.image
    }
    // function to handle the tap on the heartButton
    func heartButtonTapped(sender: UIButton) {
        
        sender.isSelected =   !sender.isSelected
        
    }

}
