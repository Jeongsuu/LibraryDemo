//
//  user.swift
//  MoyaDemo
//
//  Created by Yeojaeng on 2020/10/21.
//

struct User: Decodable {
    let id: Int
    let name: String
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
    }
}
