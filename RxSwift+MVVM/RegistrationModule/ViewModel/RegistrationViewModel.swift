//
//  RegistrationViewModel.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject

class RegistrationViewModel: ViewModelType {
    
    private let messageSubject = BehaviorSubject<String>(value: "")
    private let registraionEventSubject = PublishSubject<Void>()
    private let authorizationSuccessRelay = PublishRelay<Void>()
    
    private let decimalCharacter = CharacterSet.decimalDigits
    private let disposeBag = DisposeBag()
    
    var service: Service?
    
    init() {
        setupService()
    }
    
    struct Input {
        let name: Observable<String>
        let email: Observable<String>
        let password: Observable<String>
        let repeatPassword: Observable<String>
        let registerButtonTap: Observable<Void>
    }
    
    struct Output {
        let messageText: Driver<String>
        let buttonTapEnabled: Driver<Bool>
        let authorizationSuccess: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        handleValidMessage(input: input)
        handleRegisterButtonTap(input: input)
        
        return Output(messageText: messageText,
                      buttonTapEnabled: isValid(input: input),
                      authorizationSuccess: authorizationSuccess)
    }
}

private extension RegistrationViewModel {
    
    var messageText: Driver<String> {
        messageSubject.asDriver(onErrorJustReturn: "")
    }
    
    var authorizationSuccess: Driver<Void> {
        authorizationSuccessRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    func setupService() {
        let services = Container.sharedContainer.resolve(Services.self)
        service = services?.userDefaults
    }
    
    func isValid(input: Input) -> Driver<Bool> {
        return Observable
            .combineLatest(input.password, input.repeatPassword, input.name, input.email)
            .map { [weak self] password, repeatPassword, name, email in
                return !name.isEmpty && name.rangeOfCharacter(from: self?.decimalCharacter ?? CharacterSet()) == nil && name.count >= 8 && !email.isEmpty && !password.isEmpty && password.count >= 8 && password == repeatPassword
        }.asDriver(onErrorJustReturn: false)
    }
    
    func handleValidMessage(input: Input) {
        Observable
            .combineLatest(input.name, input.email, input.password, input.repeatPassword)
            .map { [weak self] name, email, password, repeatPassword in
                if name.count < 8 {
                    return "Имя должно быть длинее 8 символов"
                } else if name.rangeOfCharacter(from: self?.decimalCharacter ?? CharacterSet()) != nil {
                    return "Имя не должно содержать цифры"
                } else if email.isEmpty {
                    return "Введите электронную почту"
                } else if !email.contains("@") {
                    return "Некорректный Email"
                } else if password.count < 8  {
                    return "Пароль должен содержать минимум 8 символов"
                } else if password != repeatPassword {
                    return "Пароли не совпадают"
                } else {
                    return ""
                }
            }.subscribe(messageSubject)
            .disposed(by: disposeBag)
    }
    
    func handleRegisterButtonTap(input: Input) {
        input.registerButtonTap
            .withLatestFrom(Observable.combineLatest(input.name, input.email, input.password))
            .asObservable().subscribe(onNext: { [weak self] name, email, password in
                self?.service?.saveUser(name: name, email: email, password: password)
                self?.authorizationSuccessRelay.accept(())
            }
        ).disposed(by: disposeBag)
    }
}

