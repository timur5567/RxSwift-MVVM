//
//  RxSwift_MVVMTests.swift
//  RxSwift+MVVMTests
//
//  Created by msoft on 08.12.2020.
//

import XCTest
@testable import RxSwift_MVVM

class RxSwift_MVVMTests: XCTestCase {
    
//MARK:- Test UserDefaultsService
    
    func testSaveUser() {
        let userDefaults = UserDefaultsService()
        let save = userDefaults.saveUser(name: "User", email: "user123@mail.ru", password: "123456789")
        XCTAssertTrue(save)
    }
    
    func testGetUser() {
        let userDefaults = UserDefaultsService()
        let user = userDefaults.getUser()
        XCTAssertNotNil(user)
    }
}
