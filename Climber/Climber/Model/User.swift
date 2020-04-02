//
//  User.swift
//  Climber
//
//  Created by AlexChan on 2020/4/2.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var userId: String!
    var nickName: String?
    var avatarURL: String?
    
    // MARK: JSON
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        userId      <- map["userId"]
        nickName    <- map["nickName"]
        avatarURL   <- map["avatarURL"]
    }
}

extension User: CustomStringConvertible {
    var description: String {
        return "<User> \(nickName ?? "nil")"
    }
}
