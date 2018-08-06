//
//  PowerModule.swift
//  SeachbarSwiftAPi
//
//  Created by Veera Reddy on 8/5/18.
//  Copyright © 2018 Parameswar. All rights reserved.
//

import Foundation
struct PowerModule {
    
    var BlockId: Int
    var CampusId: Int
    var BlockName: String
    var CampusName: String
    
    init(_ dictionary: [String: Any]) {
        self.BlockId = dictionary["BlockId"] as? Int ?? 0
        self.CampusId = dictionary["CampusId"] as? Int ?? 0
        self.BlockName = dictionary["BlockName"] as? String ?? ""
        self.CampusName = dictionary["CampusName"] as? String ?? ""
    }
}
