//
//  APIService.swift
//  MoyaDemo
//
//  Created by Yeojaeng on 2020/10/21.
//

import Foundation

import Moya

// APIServcie가 제공하는 기능 열거
enum APIService {
    case createUser(name: String)
    case readUsers
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

// TargetType 정의
extension APIService: TargetType {
    var baseURL: URL {
//        let url = URL(string: "https://jsonplaceholder.typicode.com")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .createUser, .readUsers:
            return "/users"
        case .updateUser(let id, _), .deleteUser(let id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUsers:
            return .get
        case .updateUser(_, _):
            return .put
        case .deleteUser(_):
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        // param이 필요없는 경우
        case .readUsers, .deleteUser(_):
            return .requestPlain
            
        // param 명시가 필요한 경우
        case .createUser(let name), .updateUser(_, let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
