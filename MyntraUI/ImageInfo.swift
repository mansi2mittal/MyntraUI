//
//  ImageInfo.swift
//  MyntraUI
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import SwiftyJSON

// STRUCTURE DEFINING THE COMPATIBLE DATATYPES OF THE DATA RECEIVED FROM THE SERVER

struct ImageInfo {
    
    let id : String!
    
    var comments = 0
    var downloads = 0
    
    var favorites = 0
    var likes = 0
    var views = 0
    
    var pageURL : String = ""
    var userImageURL : String = ""
    var webformatURL : String = ""
    var previewURL : String = ""
    
    // INITIALIZER DEFINITION
    
    init(withJSON json: JSON) {
        
        self.id = json["id"].stringValue
        self.comments = json["comments"].intValue
        
        self.downloads = json["downloads"].intValue
        self.favorites = json["favorites"].intValue
        self.likes = json["likes"].intValue
        self.views = json["views"].intValue
        
        self.pageURL = json["pageURL"].stringValue
        self.userImageURL = json["userImageURL"].stringValue
        self.webformatURL = json["webformatURL"].stringValue
        self.previewURL = json["previewURL"].stringValue
        
    }
    
}


//    comments = 12;
//    downloads = 20875;
//    favorites = 80;
//    id = 1212400;
//    imageHeight = 2296;
//    imageWidth = 3514;
//    likes = 94;
//    pageURL = "https://pixabay.com/en/dog-water-run-movement-joy-1212400/";
//    previewHeight = 97;
//    previewURL = "https://cdn.pixabay.com/photo/2016/02/20/17/05/dog-1212400_150.jpg";
//    previewWidth = 150;
//    tags = "dog, water, run";
//    type = photo;
//    user = howo;
//    userImageURL = "https://cdn.pixabay.com/user/2016/02/21/16-58-44-476_250x250.jpg";
//    "user_id" = 1747689;
//    views = 30819;
//    webformatHeight = 418;
//    webformatURL = "https://pixabay.com/get/e837b00d2cf4013ed95c4518b7484096e67ee7d204b0154992f5c878aee9b1_640.jpg";
//    webformatWidth = 640;

