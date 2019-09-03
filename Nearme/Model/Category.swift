//
//  Category.swift
//  Nearme
//
//  Created by Alumnos on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import Foundation

class Category: Codable {
    var id: Int?
    var name: String?
    var description: String?
    
    init(){
        self.id = 0
        self.name = ""
        self.description = ""
    }

}
