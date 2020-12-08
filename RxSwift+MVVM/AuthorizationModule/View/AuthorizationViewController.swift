//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by msoft on 21.11.2020.
//

import UIKit
import RxSwift
import RxCocoa
import Swinject

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak private var loginTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var authorizationButton: UIButton!
    @IBOutlet weak private var registrationButton: UIButton!
    @IBOutlet weak private var errorLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var service: Service?
    
    var viewModel: AuthorizationViewModel?
    var router: AuthorizationRouter?
    
    static func instantiate() -> AuthorizationViewController {
        let storyboard = UIStoryboard(name: Storyboard.Authorization.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as? AuthorizationViewController ?? AuthorizationViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsAction()
        configureBindings()
        setupContainer()
        
        authorizationButton.layer.cornerRadius = 10
        registrationButton.layer.cornerRadius = 10
        
        loginTextField.text = service?.getUser()?.name
        passwordTextField.text = service?.getUser()?.password
    }
    
    private func setupContainer() {
        let services = Container.sharedContainer.resolve(Services.self)
        service = services?.userDefaults
    }
    
    private func setupButtonsAction() {
        registrationButton.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.router?.perform(.registration, from: self ?? AuthorizationViewController())
                }
            ).disposed(by: disposeBag)
    }

    private func configureBindings() {
        let output = viewModel?.transform(input: AuthorizationViewModel.Input(name: loginTextField.rx.text.orEmpty.asObservable(),
                                                                             password: passwordTextField.rx.text.orEmpty.asObservable(),
                                                                             authorizationButtonTap: authorizationButton.rx.tap.asObservable()))
        
        output?.authorizationError.drive(onNext: errorAnimation).disposed(by: disposeBag)
        output?.authorizationSuccess.drive(onNext: authorizationSuccess).disposed(by: disposeBag)
    }

    private func authorizationSuccess() {
        router?.perform(.onboarding, from: self)
    }
    
    private func errorAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: authorizationButton.center.x - 10, y: authorizationButton.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: authorizationButton.center.x + 10, y: authorizationButton.center.y))

        authorizationButton.layer.add(animation, forKey: "position")
    }
}

