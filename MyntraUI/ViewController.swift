//
//  ViewController.swift
//  MyntraUI
//
//  Created by Appinventiv on 16/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON


class ViewController: UIViewController {
    
    //var arrayOfWatchesImages = [ #imageLiteral(resourceName: "Image-2"), #imageLiteral(resourceName: "Image-3"),#imageLiteral(resourceName: "Image-4"),#imageLiteral(resourceName: "Image-5"), #imageLiteral(resourceName: "Image-6"), #imageLiteral(resourceName: "Image-7"), #imageLiteral(resourceName: "Image-8"),#imageLiteral(resourceName: "Image-9"), #imageLiteral(resourceName: "Image-10"), #imageLiteral(resourceName: "Image-11"), #imageLiteral(resourceName: "Image-12"), #imageLiteral(resourceName: "Image-13"), #imageLiteral(resourceName: "Image-14")]
    
   // CREATING A 2D ARRAY OF THE INDEXPATH OF THE CELLS OF THE TABLEVIEW AS WELL AS TEH COLLECTION VIEW THAT HAVE bBEN SELECTED AS FAVOURITE BY THE USER BY TAPPING ON THE HEART BUTTON
    
    var arrayOfFavourites = [[IndexPath]]()
    
    // ARRAY OF THE INDEXPATH OF THE ROWS TAHT HAVE BEEN CLICKED TO MINIMIZE
    
    var arrayOfMinimizedRows  = [IndexPath]()
    
    // ARRAY OF THE IMAGES THAT ARE CHOOSED AS FAVOURITES
    
    var arrayOfFavouriteImages = [UIImage]()
    
    // ARRAY OF THE INDEXPATH OF TEH ROWS THAT ARE BEEN SELECTED TO MINIMIZE IN A SECTION
    var arrayOfHiddenRowsOfSection = [Int]()
    
    var imagesList = [ImageInfo]()
    
    // OUTLETS
    @IBOutlet weak var viewOnTop: UIImageView!
    
    @IBOutlet weak var labelMyntra: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: VIEW LIFECYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // NOT LETTING THE AUTOMATIC ADJUSTMENT OF THE SCROLL VIEWS
        self.automaticallyAdjustsScrollViewInsets = false
        
        // CREATING THE NIB FOR THE TABLE VIEW CELL
        let cellNib = UINib( nibName : "tableViewCellTableViewCell" , bundle : nil)
        
        // REGISTERING THE NIB FOR THE TABLE VIEW CELL
        tableView.register(cellNib,forCellReuseIdentifier: "tableViewCellTableViewCellID")
        
        // CREATING THE NIB FOR THE HEADER VIEW
        let headerNib = UINib( nibName : "headerView" , bundle : nil)
        
        // REGISTERING THE NIB FOR THE HEADER VIEW
        tableView.register(headerNib , forHeaderFooterViewReuseIdentifier: "headerViewID")
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }


}
    // MARK: EXTENSION FOR TABLEVIEW
    extension ViewController : UITableViewDelegate , UITableViewDataSource  {
    
     // RETURNS THE NUMBER OF SECTIONS IN THE TABLEVIEW
     func numberOfSections(in tableView: UITableView) -> Int {
        return 3
     }
     // RETURNS THE NUMBER OF ROWS IN SECTION OF THE TABLE VIEW
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayOfHiddenRowsOfSection.contains(section)
        {
            return 0
        }
        else
        {
            return 3
        }
        
        
    }
    // RETURNS THE CELL FOR THAT PARTICULAR ROW
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellTableViewCellID", for: indexPath) as? tableViewCellTableViewCell else {
                fatalError(" Cell Not Found")
            }
        
        
        Webservices().fetchDataFromPixabay(withQuery: "dogs", success: { (images : [ImageInfo]) in
            
            self.imagesList = images
            cell.watchCollectionView.reloadData()
            
        }) { (error : Error) in
            
        }

    // EACH TIME THE CELL IS LOADED CHECKING WHETHER THE PARTICULAR ROW IS ALREADY SELECTED FOR MINIMIZING TO PERSIST THE MINIMIZATION
        
     if(arrayOfMinimizedRows.contains(indexPath)){
        
            cell.minimizeButton.isSelected = true
        }
     else{
            cell.minimizeButton.isSelected = false
        }
        
    //ADDING TARGET ON THE MINIMIZED BUTTON TO HANDLE THE TAP ON THE ROW MINIMIZED BUTTON
        
     cell.minimizeButton.addTarget(self, action: #selector(minimizeButtonTapped), for: .touchUpInside)
        
    // ASSIGNING THE DELEGATE AND DATASOURCES
     cell.watchCollectionView.delegate = self
        
     cell.watchCollectionView.dataSource = self
     return cell
        }
    
    // DEFINES THE VIEW FOR HEADER IN SECTION
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
     guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerViewID") as? headerView else {
            fatalError(" Header Not Found")
        }
     header.sectionMinimizeButton.tag = section
        
     header.sectionMinimizeButton.addTarget(self, action: #selector(sectionMinimizeButtonTapped) , for: .touchUpInside)
        
        if arrayOfHiddenRowsOfSection.contains(section)
        {
            header.sectionMinimizeButton.isSelected = true
        }
        else{
            header.sectionMinimizeButton.isSelected = false
        }
        
     header.layer.borderWidth = 4
        
     header.layer.borderColor = UIColor.black.cgColor
        
     return header
        
    }
    // REURNS THE HEIGHT FOR HEADER IN SECTION
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
         return 49
    }
    // HANDLING THE TAP ON THE MINIMIZE HEADER BUTTON
        
    func sectionMinimizeButtonTapped (sender : UIButton)
    {
        if sender.isSelected{
            
        arrayOfHiddenRowsOfSection =  arrayOfHiddenRowsOfSection.filter( {$0 != sender.tag })
        }
        else {
            arrayOfHiddenRowsOfSection.append(sender.tag)
        }
        tableView.reloadSections([sender.tag], with: .top)
        print(arrayOfHiddenRowsOfSection)
    }
    // RETURNS THE HEIGHT FOR ROW AT A PARTICULAR INDEXPATH
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    // REDUCING THE HEIGHT FOR THE ROW AS 30 IF THE ROW IS TO BE MINIMIZED ELSE THE NORMAL SIZE
        
     if arrayOfMinimizedRows.contains(indexPath)
        {
            return 30
        }
     else
        {
            return 150
        }
    }

    // FUNCTION TO HANDLE THE TAP ON THE MINIMIZED BUTTON
    
    func minimizeButtonTapped(sender: UIButton)
    {
        
        guard let tableViewCell = sender.getTableViewCell  as? tableViewCellTableViewCell  else{ return }
        
        guard let tableCellIndexPath = tableView.indexPath(for: tableViewCell) else { return }
        
        if !sender.isSelected {
            
            sender.isSelected = false
            arrayOfMinimizedRows.append(tableCellIndexPath)
            tableView.reloadRows(at: [tableCellIndexPath], with: .top)
        }
        else {
            sender.isSelected = true
            
            arrayOfMinimizedRows.remove(at: arrayOfMinimizedRows.index(of: tableCellIndexPath )!)
        }
        tableView.reloadRows(at: [tableCellIndexPath], with: .top)
    }
}

    // MARK: EXTENSION FOR COLLECTION VIEW

   extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
    
    {
    // RETURNS THE NUMBER OF ITEMS IN SECTION
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesList.count
    }
    
    // RETURNS THE CELL FOR ITEM AT INDEXPATH
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ImageCollectionViewCellID", for: indexPath) as? ImageCollectionViewCell  else {
            fatalError(" cell not Found")
        }
        
        if let url = URL(string: imagesList[indexPath.item].previewURL) {
            
            cell.imageInCell.af_setImage(withURL : url)
        }
        
        cell.imageInCell.contentMode = .scaleAspectFill
        

        
        // POULATING DATA INTO THE CELLS
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        
        // ADDING THE TARGET TO THE HEART BUTTON
        
        cell.heartButton.addTarget(self , action: #selector(heartButtonTapped), for: .touchUpInside)
        return cell
    }
    // PERFORMING ACTIONS ON THE SELECTED ITEM
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        
        let ZoomedView = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewControllerID") as! ImageZoomViewController
        
        
        // TAPPING THE CELL OF THE COLLECTION CELL WILL OPEN THE IMAGE ON FULL SCREEN ON A NEW VIEW CONTROLLER WITH ANIMATION
        
        ZoomedView.zoomImg = selectedCell.imageInCell.image
        
        UIView.animate(withDuration: 0.1 , delay: 0.0, options: .curveEaseInOut, animations:
            {  self.navigationController?.pushViewController(ZoomedView, animated: true)
                UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: self.navigationController!.view! , cache: false)
            }, completion:nil )
    
    }
    
     // HANDLING THE TAP ON THE FAVOURITE BUTTON
    
    func heartButtonTapped(sender: UIButton) {
        
        // FETCHING THE SUPERVIEW OF THE SENDER BY CALLING THE EXTENSION'S COMPUTED PROPERTIES
        
        guard  let tableViewCell = sender.getTableViewCell as? tableViewCellTableViewCell else { return }
        
        let tableCellIndexPath = tableView.indexPath(for: tableViewCell)
        
       guard  let collectionCell = sender.getCollectionViewCell as? ImageCollectionViewCell else  { return }
        
        let collectionCellIndexPath = tableViewCell.watchCollectionView.indexPath(for: collectionCell)
        
         if sender.isSelected {
            
            sender.isSelected = false
            arrayOfFavourites =   arrayOfFavourites.filter({ (index : [IndexPath]) -> Bool in
                return index != [tableCellIndexPath! , collectionCellIndexPath!]
            })
        }
         else {
           sender.isSelected = true
           arrayOfFavourites.append([tableCellIndexPath! , collectionCellIndexPath!])
       }
         print(arrayOfFavourites)
    }
    
// SETTING THE COLLECTION VIEW LAYOUT SPECYFING THE SIZE OF THE ITEM
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout , sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 120 , height: 120)
    }
    

}

// MARK: NAVIGATION




