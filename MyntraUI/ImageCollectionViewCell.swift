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
     var data : ImageInfo!
    
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        // Initialization code
    }

    // function to handle the tap on the heartButton
    func heartButtonTapped(sender: UIButton) {
        
        sender.isSelected =   !sender.isSelected
        
    }

}
