//
//  ImageZoomViewController.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

   class ImageZoomViewController: UIViewController {
    
    @IBOutlet weak var zoomedImage: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    var imageURL : URL!
    
    var zoomImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomedImage.image = zoomImg
    }
    
    override func viewWillLayoutSubviews() {
        
        zoomedImage.af_setImage(withURL: imageURL)
    }


     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // on the click of the close button the image, hoem screen will appear and the image full screen view controller will be popped back
    
    //  MARK : ACTIONS
      @IBAction func closeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            self.navigationController?.popViewController(animated: true)
        })

    }
    
    // function to populate data 
    
 
    
    


}
