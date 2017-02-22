//
//  ImageZoomViewController.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

   class ImageZoomViewController: UIViewController {
    
    // OUTLETS
    
    @IBOutlet weak var zoomedImage: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    // VARIABLE TO STORE THE IMAGE URL AS URL
    
    var imageURL : URL!
    
    // VARIABLE TO PASS AS THE IMAGE IN THE UIIMAGE VIEW
    
    var zoomImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomedImage.image = zoomImg
    }
    
    // FUNCTION TO LAYOUT SUBVIEWS WHWN THE VIEW WILL LOAD 
    
    override func viewWillLayoutSubviews() {
        
        zoomedImage.af_setImage(withURL: imageURL)
    }


     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // CLICKING THE CLOSE BUTTON , HOME SCREEN WILL APPEAR
    
    //  MARK : ACTIONS
      @IBAction func closeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            self.navigationController?.popViewController(animated: true)
        })

    }
    
 
    
    


}
