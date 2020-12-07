//
//  UserDefaultService.swift
//  RxSwift+MVVM
//
//  Created by msoft on 24.11.2020.
//

import Foundation
import RxSwift

class UserDefaultsService: Service {
    
    func saveUser(name: String, email: String, password: String) -> Bool {
        let defaults = UserDefaults.standard
        let registrationModel = RegistrationModel(name: name, email: email, password: password)
            if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: registrationModel, requiringSecureCoding: false) {
                defaults.set(saveData, forKey: "key")
                return true
            }
        return false
    }
    
    func getUser() -> RegistrationModel? {
        if let savedData = UserDefaults.standard.object(forKey: "key") as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? RegistrationModel {
            return decodedModel
        }
        return nil
    }
}
