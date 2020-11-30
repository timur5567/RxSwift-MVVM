//
//  AuthorizationViewModel.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import Foundation
import RxSwift
import RxCocoa

class AuthorizationViewModel: ViewModelType {
    
    private let messageSubject = BehaviorSubject<String>(value: "")
    private let authorizationSuccessRelay = PublishRelay<Void>()
    private let authorizationErrorRelay = PublishRelay<Void>()
    
    private let userDefaults = UserDefaultService()
    private let disposeBag = DisposeBag()

    struct Input {
        let name: Observable<String>
        let password: Observable<String>
        let authorizationButtonTap: Observable<Void>
    }
    
    struct Output {
        let authorizationError: Driver<Void>
        let authorizationSuccess: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        handleAuthorizationButtonTap(input: input)
        
        return Output(authorizationError: authorizationError,
                      authorizationSuccess: authorizationSuccessful)
    }
}
    
private extension AuthorizationViewModel {
    
    var authorizationError: Driver<Void> {
        authorizationErrorRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    var authorizationSuccessful: Driver<Void> {
        authorizationSuccessRelay.asDriver(onErrorDriveWith: Driver.never())
    }
    
    func handleAuthorizationButtonTap(input: Input) {
        input.authorizationButtonTap
            .withLatestFrom(Observable.combineLatest(input.name, input.password))
            .asObservable().subscribe(onNext: { [weak self] name, password in
                if name == self?.userDefaults.registrationModel?.name && password == self?.userDefaults.registrationModel?.password {
                    self?.authorizationSuccessRelay.accept(())
                } else {
                    self?.authorizationErrorRelay.accept(())
                }
            }).disposed(by: disposeBag)
    }
}
