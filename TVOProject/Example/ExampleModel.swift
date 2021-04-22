//
//  ExampleModel.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import Foundation
import ObjectMapper

//get_statistic_data
class StatisticDataModel: BaseModel {
    var data: DataModel?
    var status: Bool?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
        status <- map["status"]
    }
}

class DataModel: Mappable {
    var total_profit: Float?
    var pairs: [DataPairsModel]?
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        total_profit <- map["total_profit"]
        pairs <- map["pairs"]
    }
}

class DataPairsModel: Mappable {
    var avg_percent: Float?
    var pair: String?
    var profit: Float?
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        avg_percent <- map["avg_percent"]
        pair <- map["pair"]
        profit <- map["profit"]
    }
}

//get_observing_pairs
class ObservingPairsModel: BaseModel {
    var data: JobsModel?
    var status: Bool?
    
    required init?(map: Map){
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
        status <- map["status"]
    }
}

class JobsModel: Mappable {
    var jobs: [String]?
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        jobs <- map["jobs"]
    }
}
