//
//  RegistrationModel.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import Foundation

class RegistrationModel: NSObject, NSCoding {

    var name: String
    var email: String
    var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(email, forKey: "email")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        email = coder.decodeObject(forKey: "email") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
    }
}

