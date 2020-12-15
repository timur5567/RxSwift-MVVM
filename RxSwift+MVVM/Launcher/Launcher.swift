//
//  Launcher.swift
//  RxSwift+MVVM
//
//  Created by msoft on 27.11.2020.
//

import UIKit

class Launcher {
    static func launch(with window: UIWindow?) {
        let authorizationVC = AuthorizationViewController(nibName: NibName.authorization.rawValue, bundle: nil)
        authorizationVC.viewModel = AuthorizationViewModel()
        authorizationVC.router = AuthorizationRouter()
        let navigationController = UINavigationController(rootViewController: authorizationVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


