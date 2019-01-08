//
//  UserData.swift
//  Cat Facts
//
//  Created by Nikita Nechyporenko on 05.01.2019.
//  Copyright © 2019 Nikita Nechyporenko. All rights reserved.
//

import Foundation
import RealmSwift

class UserData {
    var email: String
    var password: String
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

class Response {
    var name: String
    var text: String
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
}

class UserRegistrationData: Object {
    @objc dynamic var userEmail = ""
    @objc dynamic var userPassword = ""
}

var arrData = [Response]()
