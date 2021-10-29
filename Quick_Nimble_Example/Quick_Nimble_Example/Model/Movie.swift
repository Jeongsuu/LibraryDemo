//
//  Movie.swift
//  Quick_Nimble_Example
//
//  Created by 여정수 on 2021/10/29.
//

import Foundation

struct Movie {
    var title: String
    var genre: Genre
    var genreString: String {
        switch genre {
        case .Action:
            return "Action"
        case .Animation:
            return "Animation"
        case .None:
            return "None"
        }
    }
}
