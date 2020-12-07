//
//  Protocols.swift
//  RxSwift+MVVM
//
//  Created by msoft on 04.12.2020.
//

import Foundation

enum Storyboard: String {
    case Authorization
    case Registration
    case Onboarding
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol Service {
    func getUser() -> RegistrationModel?
    func saveUser(name: String, email: String, password: String) -> Bool
}
