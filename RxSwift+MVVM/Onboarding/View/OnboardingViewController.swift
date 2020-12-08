//
//  OnboardingViewController.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import UIKit
import Swinject

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak private var greetingLabel: UILabel!
    
    var service: Service?
    
    static func instantiate() -> OnboardingViewController {
        let storyboard = UIStoryboard(name: Storyboard.Onboarding.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! OnboardingViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupService()
        
        if let nickName = service?.getUser()?.name {
            greetingLabel.text = "Добро пожаловать! ✨\(nickName)✨"
        }
        
    }
    
    func setupService() {
        let services = Container.sharedContainer.resolve(Services.self)
        service = services?.userDefaults
    }
}
