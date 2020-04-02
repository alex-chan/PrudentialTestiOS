//
//  UserService.swift
//  Climber
//
//  Created by AlexChan on 2020/4/2.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation
import RxSwift
import Moya.Swift


enum UserService {
    case login(email: String, password: String)
    case steps(userId: String)
}

// MARK: - TargetType Protocol Implementation
extension UserService: TargetType {
    var baseURL: URL { return URL(string: "https://api.myservice.com")! }
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .steps(let userId):
            return "/users/\(userId)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .steps:
            return .get
        case .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .steps(_):  // Always sends parameters in URL, regardless of which HTTP method is used
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case let .login(email, password): // Always send parameters as JSON in request body
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
      
        case .steps(let userId):
            return "{\"id\": \(userId), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
        case .login(let email, let password):
            return "{\"id\": 100, \"email\": \"\(email)\", \"password\": \"\(password)\"}".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
