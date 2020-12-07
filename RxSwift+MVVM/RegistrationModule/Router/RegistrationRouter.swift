//
//  RegistrationRouter.swift
//  RxSwift+MVVM
//
//  Created by msoft on 25.11.2020.
//

import UIKit

enum RegistrationSegue {
    
    case authorization
}

protocol RegisterRouter {
    
    func perform(_ segue: RegistrationSegue, from source: RegistrationViewController)
}

class RegistrationRouter: RegisterRouter {
    
    func perform(_ segue: RegistrationSegue, from source: RegistrationViewController) {
        switch segue {
        case .authorization:
            source.navigationController?.dismiss(animated: true)
        }
    }
}

private extension RegistrationRouter {

}
