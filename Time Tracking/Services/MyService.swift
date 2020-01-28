//
//  MyService.swift
//  Time Tracking
//
//  Created by Nina Dominique Thomé Bernardo - NBE on 28/01/20.
//  Copyright © 2020 ios-estags-iteris. All rights reserved.
//

import Foundation
import Moya
enum MyService {
    case showPeople
}
extension MyService: TargetType {
    var sampleData: Data {
        switch self {
        case .showPeople:
            guard let url = Bundle.main.url(forResource: "people", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "https://us-central1-timetracking-2cb92.cloudfunctions.net")! }
    var path: String {
        switch self {
        case .showPeople:
            return "/people"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showPeople:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .showPeople:
            return .requestPlain
        }
    }
}
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
