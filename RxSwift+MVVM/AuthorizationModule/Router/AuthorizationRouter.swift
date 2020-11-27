//
//  AuthorizationRouter.swift
//  RxSwift+MVVM
//
//  Created by msoft on 25.11.2020.
//

import UIKit


enum AuthorizationSegue {

    case registration
    case onboarding
}

protocol LoginRouter {
    
    func perform(_ segue: AuthorizationSegue, from source: AuthorizationViewController)
}

class AuthorizationRouter: LoginRouter {
    
    func perform(_ segue: AuthorizationSegue, from source: AuthorizationViewController) {
        switch segue {
        case .registration:
            let viewController = AuthorizationRouter.makeRegistrationViewController()
            source.navigationController?.present(viewController, animated: true)
            
        case .onboarding:
            let viewController = AuthorizationRouter.makeOnboardingViewController()
            source.navigationController?.present(viewController, animated: true)
        }
    }
}

private extension AuthorizationRouter {
    
    static func makeRegistrationViewController() -> UINavigationController {
        let viewController = RegistrationViewController.instantiate()
        viewController.router = RegistrationRouter()
        viewController.viewModel = RegistrationViewModel()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    static func makeOnboardingViewController() -> UINavigationController {
        let viewController = OnboardingViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.modalPresentationStyle = .fullScreen
        
        return navigationController
    }
}
