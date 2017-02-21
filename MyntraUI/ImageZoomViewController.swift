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
    
    var zoomImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomedImage.image = zoomImg
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // on the click of the close button the image, hoem screen will appear and the image full screen view controller will be popped back
    
    //  MARK : ACTIONS
      @IBAction func closeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, animations: {
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            self.navigationController?.popViewController(animated: true)
            UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: self.navigationController!.view! , cache: false)
        })

    }
    
    // function to populate data 
    
    func populateWithData(_ data: WatchModel)
    {
        zoomedImage.image = data.image
    }
    
    


}
