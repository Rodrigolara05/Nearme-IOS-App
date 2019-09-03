//
//  Type_User.swift
//  Nearme
//
//  Created by Alumnos on 6/6/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import Foundation
struct Type_User: Codable {
    var id: Int
    var description: String
    var name: String
    
    init() {
        self.id = 0
        self.description = ""
        self.name = ""
    }
}
