//
//  PersonFollowingTableViewViewModel.swift
//  MVVMDemo
//
//  Created by Yeojaeng on 2020/11/05.
//

import Foundation
import UIKit

struct PersonFollowingTableViewCellViewModel {
    
    // MARK: - Properties
    
    let name: String
    let username: String
    var currenntlyFollowing: Bool
    let image: UIImage?
    
    // Initializer
    init(with model: Person) {
        name = model.name
        username = model.username
        currenntlyFollowing = false
        image = UIImage(systemName: "person")
    }
}
