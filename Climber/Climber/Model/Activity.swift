//
//  Activity.swift
//  Climber
//
//  Created by AlexChan on 2020/4/2.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation
import ObjectMapper

struct Activity: Mappable {
    var steps: Int!
    var date: Date!

    // MARK: JSON
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        steps       <- map["steps"]
        date        <- map["date"]
    }
}

extension Activity: CustomStringConvertible {
    var description: String {
        return "<Activity> \(steps ?? 0)"
    }
}
