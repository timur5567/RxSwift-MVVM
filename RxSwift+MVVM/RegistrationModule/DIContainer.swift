//
//  DIContainer.swift
//  RxSwift+MVVM
//
//  Created by msoft on 02.12.2020.
//

import Foundation
import Swinject

class Services {
    let userDefaults: UserDefaultsService
    
    init(userDef: UserDefaultsService) {
        self.userDefaults = userDef
    }
}

extension Container {
    static let sharedContainer: Container = {
        let container = Container()
        
        container.register(Services.self) { r in
            let userDef = UserDefaultsService()
            return Services(userDef: userDef)
        }
        return container
    }()
}
