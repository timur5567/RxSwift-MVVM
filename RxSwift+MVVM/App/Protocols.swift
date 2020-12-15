//
//  Protocols.swift
//  RxSwift+MVVM
//
//  Created by msoft on 04.12.2020.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol Service {
    func getUser() -> RegistrationModel?
    func saveUser(name: String, email: String, password: String) -> Bool
}

enum NibName: String {
    case authorization = "Authorization"
    case registration = "Registration"
    case onboarding = "Onboarding"
}


