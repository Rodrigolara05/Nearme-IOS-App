//
//  User.swift
//  Nearme
//
//  Created by Alumnos on 6/6/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int?
    var email: String?
    var fullname: String?
    var image: String?
    var password: String?
    var gender: String?
    var username: String?
    var type_user_id: Type_User?
    
    init() {
        self.id = 0
        self.email = ""
        self.fullname = ""
        self.image = ""
        self.password = ""
        self.gender = ""
        self.username = ""
        self.type_user_id = Type_User.init()
    }
    
    func toJson() -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return jsonData
    }
}
