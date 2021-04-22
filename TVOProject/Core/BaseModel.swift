//
//  BaseModel.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    var error_code: Int?
    var message: String?
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        error_code <- map["error_code"]
        message <- map["message"]
    }
}
