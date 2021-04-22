//
//  ExampleEndpoint.swift
//  TVOProject
//
//  Created by Ngavt on 4/16/21.
//

import Foundation
import Moya

enum ExampleEndpoint {
    case get_statistic_data(params: [String: Any])
    case get_observing_pairs
}

extension ExampleEndpoint: TargetType {
    var task: Task {
        switch self {
        case let .get_statistic_data(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .get_observing_pairs:
            return .requestPlain
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .get_statistic_data:
            return .post
        case .get_observing_pairs:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .get_statistic_data:
            return "/get_statistic_data"
        case .get_observing_pairs:
            return "/get_observing_pairs"
        }
    }
        
}

