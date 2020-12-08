//
//  OnboardingRouter.swift
//  RxSwift+MVVM
//
//  Created by msoft on 08.12.2020.
//

import Foundation

enum OnboardingSegue {
    
}

protocol OnboardRouter {
    
    func perform(_ segue: OnboardingSegue, from source: OnboardingViewController)
}

class OnboardingRouter: OnboardRouter {
    func perform(_ segue: OnboardingSegue, from source: OnboardingViewController) {
        
    }
}

private extension OnboardingRouter {
    
}

