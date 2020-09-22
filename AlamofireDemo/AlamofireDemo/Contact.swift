//
//  Contact.swift
//  AlamofireDemo
//
//  Created by Yeojaeng on 2020/09/22.
//

import Foundation

struct APIResponse: Codable {
    let contacts: [Contact]
}

struct Contact: Codable {

    let name: String
    let email: String
    let gender: String
}
