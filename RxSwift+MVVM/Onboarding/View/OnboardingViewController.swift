//
//  OnboardingViewController.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static func instantiate() -> OnboardingViewController {
        let storyboard = UIStoryboard(name: Storyboard.Onboarding.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as? OnboardingViewController ?? OnboardingViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
