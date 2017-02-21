//
//  NetworkController.swift
//  MyntraUI
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias JSONDictionary = [String:Any]

class NetworkController {
    
    func GET(URL : String,
             parameters : JSONDictionary,
             headers : JSONDictionary? = nil,
             success : @escaping (_ json : JSON) -> (),
             failure : @escaping (_ error : Error) -> ()) {
        
        // REQUEST TO FETCH DATA FROM THE SERVER
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response :DataResponse<Any>) in
                            
                            if let value = response.value as? [String:Any] {
                                
                                let json = JSON(value)
                                success(json)
                                
                            } else if let error = response.error {
                                
                                failure(error)
                            }
        }
    }
    
}





