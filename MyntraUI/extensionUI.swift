//
//  extensionUI.swift
//  MyntraUI
//
//  Created by Appinventiv on 18/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

 // CREATING AN EXTENSION OF THE UIVIEW SO AS TO FETCH THE DESIRED SUPERVIEW WHEN THE OBJECT IS REACHED

   extension UIView {
    
    var  getTableViewCell : UITableViewCell? {
        
        var subview = self
        
        while !( subview is UITableViewCell) {
            
            guard let superviewReturned = subview.superview else {  return nil  }
            subview = superviewReturned
        }
    
    return subview as? UITableViewCell
}

    var  getCollectionViewCell : UICollectionViewCell? {
    
    var subview = self
        
    while !( subview is UICollectionViewCell) {
        
        guard let superviewReturned = subview.superview else {  return nil  }
        
        subview = superviewReturned
    }
    return subview as? UICollectionViewCell
  }
}
