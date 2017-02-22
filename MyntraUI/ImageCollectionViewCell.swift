//
//  ImageCollectionViewCell.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // VARIABLE TO STORE THE IMAGE INFO 
    
     var data : ImageInfo!
    
    // OUTLETS
    
    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageInCell.contentMode = .scaleAspectFill

    }
        
    }
