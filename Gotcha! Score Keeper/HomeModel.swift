//
//  HomeModel.swift
//  Gotcha! Score Keeper
//
//  Created by Peter Jaworski on 2/17/19.
//  Copyright © 2019 Peter Jaworski. All rights reserved.
//

import Foundation

class Item: Codable {
    var id: String?
    var name: String?
    var points: Int
    
    init(id: String?, name: String?, points: Int = 0) {
        self.id = id
        self.name = name
        self.points = points
    }
}
