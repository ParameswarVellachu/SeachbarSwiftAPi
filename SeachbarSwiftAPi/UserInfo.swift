//
//  File.swift
//  SeachbarSwiftAPi
//
//  Created by Veera Reddy on 8/4/18.
//  Copyright © 2018 Parameswar. All rights reserved.
//

import Foundation

import Foundation
struct UserInfo {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? Int ?? 0
        self.id = dictionary["id"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? ""
        self.completed = dictionary["completed"] as? Bool ?? false
    }
}
