//
//  RegistrationViewController.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import UIKit
import RxSwift
import RxCocoa

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
        
    private let disposeBag = DisposeBag()
    
    var viewModel: RegistrationViewModel?
    var router: RegistrationRouter?
    
    static func instantiate() -> RegistrationViewController {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as? RegistrationViewController ?? RegistrationViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        registerButton.layer.cornerRadius = 10
    }
    
    private func configureBindings() {
        let output = viewModel?.transform(input:RegistrationViewModel.Input(name: nameTextField.rx.text.orEmpty.asObservable(),
                                                              email: emailTextField.rx.text.orEmpty.asObservable(),
                                                              password: passwordTextField.rx.text.orEmpty.asObservable(),
                                                              repeatPassword: repeatPasswordTextField.rx.text.orEmpty.asObservable(),
                                                              registerButtonTap: registerButton.rx.tap.asObservable()))
        
        output?.buttonTapEnabled.drive(registerButton.rx.isEnabled).disposed(by: disposeBag)
        output?.buttonTapEnabled.map{ $0 ? 1 : 0.3 }.drive(registerButton.rx.alpha).disposed(by: disposeBag)
        output?.authorizationSuccess.drive(onNext: goToAuthorization).disposed(by: disposeBag)
        output?.messageText.drive(errorLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func goToAuthorization() {
        router?.perform(.authorization, from: self)
    }
}


