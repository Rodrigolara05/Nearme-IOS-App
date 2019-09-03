//
//  Enterprise.swift
//  Nearme
//
//  Created by Alumnos on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import Foundation

class Enterprise: Codable {
    var id: Int?
    var categoryId: Category?
    var description: String?
    var image: String?
    var location: String?
    var name: String?
    var longitude: String?
    var latitude: String?
    var star: String?
    
    init() {
        self.id = 0
        self.categoryId = Category.init()
        self.description = ""
        self.image = ""
        self.location = ""
        self.name = ""
        self.longitude = ""
        self.latitude = ""
        self.star = ""
    }

}
