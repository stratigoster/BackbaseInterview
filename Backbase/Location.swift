//
//  Location.swift
//  Backbase
//
//  Created by William  on 2018-11-19.
//  Copyright © 2018 William . All rights reserved.
//

import Foundation

struct Location:Decodable {
    var _id: Int
    struct Coor: Decodable {
        var lat: Double
        var lon: Double
    }
    var coord : Coor
    var country: String
    var name: String
}
