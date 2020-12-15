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

protocol AuthRouter {
    func perform(_ segue: AuthorizationSegue, from source: AuthorizationViewController)
}

class AuthorizationRouter: AuthRouter {
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
        let viewController = RegistrationViewController(nibName: NibName.registration.rawValue, bundle: nil)
        viewController.router = RegistrationRouter()
        viewController.viewModel = RegistrationViewModel()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    static func makeOnboardingViewController() -> UINavigationController {
        let viewController = OnboardingViewController(nibName: NibName.onboarding.rawValue, bundle: nil)
        viewController.viewModel = OnboardingViewModel()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalTransitionStyle = .flipHorizontal
        navigationController.modalPresentationStyle = .fullScreen
        
        return navigationController
    }
}
