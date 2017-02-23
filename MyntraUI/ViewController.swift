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
        
    typealias JSONDictionary = [[String:Any]]
    
   // CREATING A 2D ARRAY OF THE INDEXPATH OF THE CELLS OF THE TABLEVIEW AS WELL AS TEH COLLECTION VIEW THAT HAVE bBEN SELECTED AS FAVOURITE BY THE USER BY TAPPING ON THE HEART BUTTON
    
    var arrayOfFavourites = [[IndexPath]]()
    
    // ARRAY OF THE INDEXPATH OF THE ROWS TAHT HAVE BEEN CLICKED TO MINIMIZE
    
    var arrayOfMinimizedRows  = [IndexPath]()
    
    // ARRAY OF THE IMAGES THAT ARE CHOOSED AS FAVOURITES
    
    var arrayOfFavouriteImages = [UIImage]()
    
    // ARRAY OF THE INDEXPATH OF THE ROWS THAT ARE BEEN SELECTED TO MINIMIZE IN A SECTION
        
    var arrayOfHiddenRowsOfSection = [Int]()
    
    //  3D ARRAY OF IMAGES THAT IS BEEN FETCHED ON HITTING THE SERVICE CONTAINING THE INFORMATION ABOUT SECTION ROW AND INDEXPATH
        
    var imagesList =  [[[ImageInfo]]]()
    
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
        
        // REGISTERING THE NIB FOR THE HEADER VIEW INSIDE THE TABLE VIEW
        tableView.register(headerNib , forHeaderFooterViewReuseIdentifier: "headerViewID")
        
        // FUNCTION CALLING 
        fetchData()
        
    }

     override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
      }
    }


    // MARK: EXTENSION FOR TABLEVIEW

    extension ViewController : UITableViewDelegate , UITableViewDataSource  {
    
     // RETURNS THE NUMBER OF SECTIONS IN THE TABLEVIEW
        
    func  numberOfSections(in tableView: UITableView) -> Int {
        
        return imagesList.count
     }
        
     // RETURNS THE NUMBER OF ROWS IN SECTION OF THE TABLE VIEW
        
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayOfHiddenRowsOfSection.contains(section)
        {
            return 0
        }
        else
        {
            return imagesList[section].count
        }
        
        
       }
     // RETURNS THE CELL FOR THAT PARTICULAR ROW
        
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellTableViewCellID", for: indexPath) as? tableViewCellTableViewCell else {
                fatalError(" Cell Not Found")
             }
        
        let dataVariable = JsonData.entireData[indexPath.section]["Value"] as! JSONDictionary
        
        cell.watchLabel.text = dataVariable[indexPath.row]["Sub Category"] as? String
        
            return cell
        }
        
       // WILL DISPLAY A PARTICULAR CELL AT A PARTICULAR INDEXPATH
        
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            guard  let tableCell = cell as? tableViewCellTableViewCell else {  fatalError(" Cell Not Found")}
            
            // ASSIGNING THE DELEGATE AND DATASOURCES
            
            tableCell.watchCollectionView.delegate = self
            
            tableCell.watchCollectionView.dataSource = self
            
            
            // EACH TIME THE CELL IS LOADED CHECKING WHETHER THE PARTICULAR ROW IS ALREADY SELECTED FOR MINIMIZING TO PERSIST THE MINIMIZATION
            
            if(arrayOfMinimizedRows.contains(indexPath)){
                
                tableCell.minimizeButton.isSelected = true
            }
            else{
                tableCell.minimizeButton.isSelected = false
            }
            
            //ADDING TARGET ON THE MINIMIZED BUTTON TO HANDLE THE TAP ON THE ROW MINIMIZED BUTTON
            
            tableCell.minimizeButton.addTarget(self, action: #selector(minimizeButtonTapped), for: .touchUpInside)
            
            tableCell.tableIndexPath = indexPath
            
            }
    
      // DEFINES THE VIEW FOR HEADER IN SECTION
        
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
      guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerViewID") as? headerView else {
            fatalError(" Header Not Found")
        }
        
        header.label.text = JsonData.entireData[section]["Category"] as? String
        
     // EACH TIME A HEADER IS CREATED CHECKING WHETHER IS IS BEEN SELECTED TO MINIMIZE ITSELF BY ASSIGNING THE TAG TO THE BUTTON AS THE SECTION NUMBER SO THAT WE CAN KNOW WHICH SECTION'S BUTTON IS BEEN TAPPED.
        
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
        
        
     // HANDLING THE TAP ON THE MINIMIZE HEADER BUTTON
        
    func sectionMinimizeButtonTapped (sender : UIButton)
     {
      if sender.isSelected{
            
        sender.isSelected = false
        arrayOfHiddenRowsOfSection =  arrayOfHiddenRowsOfSection.filter( {$0 != sender.tag })
            
        }
       else
        {
            sender.isSelected = true
            arrayOfHiddenRowsOfSection.append(sender.tag)
        }
        
        tableView.reloadSections([sender.tag], with: .top)
        //print(arrayOfHiddenRowsOfSection)
    }
        
    // FUNCTION TO HANDLE THE TAP ON THE MINIMIZED BUTTON
    
    func minimizeButtonTapped(sender: UIButton)
    {
        
        guard let tableViewCell = sender.getTableViewCell  as? tableViewCellTableViewCell  else{ return }
        
        guard let tableCellIndexPath = tableView.indexPath(for: tableViewCell) else { return }
        
        if sender.isSelected {
            
            sender.isSelected = false
            arrayOfMinimizedRows.remove(at: arrayOfMinimizedRows.index(of: tableCellIndexPath )!)
                    }
        else {
            sender.isSelected = true
            arrayOfMinimizedRows.append(tableCellIndexPath)
              }
        
        tableView.reloadRows(at: [tableCellIndexPath], with: .top)
       }
     }

     // MARK: EXTENSION FOR COLLECTION VIEW

     extension ViewController : UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
    
     {
     // RETURNS THE NUMBER OF ITEMS IN SECTION

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let tablecell = collectionView.getTableViewCell as! tableViewCellTableViewCell
        
        return imagesList[tablecell.tableIndexPath.section][tablecell.tableIndexPath.row].count
        
    }
    
    // RETURNS THE CELL FOR ITEM AT INDEXPATH
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ImageCollectionViewCellID", for: indexPath) as? ImageCollectionViewCell  else {
            fatalError(" cell not Found")
        }
        
        guard  let tableViewCell = collectionView.getTableViewCell as? tableViewCellTableViewCell else { fatalError( " Cell Not Found")  }
        
        // STORING THE IMAGES OF A PARTICULAR SECTION AND ROW IN A VARIABLE
        
        let imageInformationData = imagesList[tableViewCell.tableIndexPath.section][tableViewCell.tableIndexPath.row][indexPath.item]
        
        if let url = URL(string: imageInformationData.previewURL) {
            
        cell.imageInCell.af_setImage(withURL : url)
            
        }

        // HIDING THE LABEL IN THE CELL
        
         cell.label.isHidden = true
        
        // ASSIGNING THE INDEXPATH OF THE CELL SPECIFYING THE SECTION, ROW AND INDEXPATH OF THE CELL.
        
         cell.label.text  = "\(tableViewCell.tableIndexPath!.section)  \(tableViewCell.tableIndexPath!.row)\(indexPath.row)"
        
        // PERSISTING THE CELLS THAT HAVE BEEN SELECTED AS FAVOURITE
        
        if  arrayOfFavourites.contains (where:{ (index : [IndexPath]) -> Bool in
            return index == [tableViewCell.tableIndexPath! , indexPath] })
        {
            cell.heartButton.isSelected = true
        }
        else{
            cell.heartButton.isSelected = false
        }

        cell.imageInCell.contentMode = .scaleAspectFill
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.black.cgColor
        
        // ADDING THE TARGET TO THE HEART BUTTON
        
        cell.heartButton.addTarget(self , action: #selector(heartButtonTapped), for: .touchUpInside)
        return cell
    }
    // PERFORMING ACTIONS ON THE SELECTED ITEM
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tableViewCell = collectionView.getTableViewCell as! tableViewCellTableViewCell
        
        let ZoomedView = self.storyboard?.instantiateViewController(withIdentifier: "ImageZoomViewControllerID") as! ImageZoomViewController
        
        // TAPPING THE CELL OF THE COLLECTION CELL WILL OPEN THE IMAGE ON FULL SCREEN ON A NEW VIEW CONTROLLER WITH ANIMATION
        
        UIView.animate(withDuration: 0.1 , delay: 0.0, options: .curveEaseInOut, animations:
            {  self.navigationController?.pushViewController(ZoomedView, animated: true)
        }, completion:nil )

        let imageInformationData = imagesList[tableViewCell.tableIndexPath.section][tableViewCell.tableIndexPath.row][indexPath.item]

        ZoomedView.imageURL = URL(string : imageInformationData.webformatURL)
        
        }
        
    // SETTING THE COLLECTION VIEW LAYOUT SPECYFING THE SIZE OF THE ITEM
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout , sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: 120 , height: 120)
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
        
        // FUNCTION TO LOAD THE IMAGES ACCORDING TO THE CATEGORIES DEFINED INSIDE THE JASON 
        
        func fetchData(){
            
            for section in JsonData.entireData.indices
            {
                imagesList.append([])
                
                for (index, value) in (JsonData.entireData[section]["Value"] as! JSONDictionary).enumerated()
                {
                    imagesList[section].append([])

                    Webservices().fetchDataFromPixabay(withQuery: value["Sub Category"] as! String,
                                                       success: { (input : [ImageInfo]) in
                                                        self.imagesList[section][index] = input
                                                        
                                                        //ALERT IF IMAGE NOT FOUND
                                                        if self.imagesList.count == 0{
                                                            
                                                            let alert = UIAlertController(title: "Alert", message: "Please Enter a valid value", preferredStyle: UIAlertControllerStyle.alert)
                                                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                                            self.present(alert, animated: true, completion: nil)
                                                        }
                                                        else{
                                                            self.tableView.reloadData()
                                                        }
                                                        
                    })
                    {
                        //ALERT FOR NO INTERNET
                        (error : Error) in
                        let alert = UIAlertController(title: "Alert", message: "No Network Connection", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
        }
    
     }




