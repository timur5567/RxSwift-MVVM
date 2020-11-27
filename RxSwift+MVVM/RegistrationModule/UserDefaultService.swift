//
//  UserDefaultService.swift
//  RxSwift+MVVM
//
//  Created by msoft on 24.11.2020.
//

import Foundation
import RxSwift


class UserDefaultService {
    
    var registrationModel: RegistrationModel? {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: "key") as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? RegistrationModel else  {
                return nil
            }
            return decodedModel
        } set {
            let defaults = UserDefaults.standard
            if let registrationModel = newValue {
                if let saveData = try? NSKeyedArchiver.archivedData(withRootObject: registrationModel, requiringSecureCoding: false) {
                    defaults.set(saveData, forKey: "key")
                    print("save")
                }
            }
        }
    }
    
    func registrationUser(name: String, email: String, password: String) {
        self.registrationModel = RegistrationModel(name: name, email: email, password: password)
    }
}
