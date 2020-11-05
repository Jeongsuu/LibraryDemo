//
//  Models.swift
//  MVVMDemo
//
//  Created by Yeojaeng on 2020/11/05.
//

import Foundation

enum Gender {
    case male
    case female
    case unspecified
}

// Model
struct Person {
    
    // MARK: - properties
    
    let name: String
    let birthDate: Date?
    let middleName: String?
    let address: String?
    let gender: Gender
    var username = "YeoJungSu"
    
    // Initializer
    init(name: String, birthDate: Date? = nil,
         middleName: String? = nil, address: String? = nil, gender: Gender = .unspecified) {
        self.name = name
        self.birthDate = birthDate
        self.middleName =  middleName
        self.address = address
        self.gender = gender
    }
}
