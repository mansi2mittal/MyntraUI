//
//  webservices.swift
//  MyntraUI
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import SwiftyJSON

class Webservices {
    
    func fetchDataFromPixabay(withQuery query: String,
                             // page: Int,
                              success : @escaping (([ImageInfo]) -> Void),
                              failure : @escaping ((Error) -> Void)) {
        
        let URL = "https://pixabay.com/api/"
        
        let parameters = ["key" : "4605957-37b558ec4bd8690ce822e16e7",
                          "q" : query,
                          //"page": page
        ] as [String : Any]
        
        NetworkController().GET(URL: URL,
                                parameters : parameters,
                                success : { (json : JSON) in
                                    
                                    print(json)
                                    
                                    let imagesArray = json["hits"].arrayValue
                                    
                                    var imageModels = [ImageInfo]()
                                    
                                    for image in imagesArray {
                                        
                                        imageModels.append(ImageInfo(withJSON: image))
                                    }
                                    
                                    success(imageModels)
                                    
                                    
        }, failure : { (error : Error) in
            
            failure(error)
        })
        
    }
    
}


