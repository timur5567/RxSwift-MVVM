//
//  Launcher.swift
//  RxSwift+MVVM
//
//  Created by msoft on 27.11.2020.
//

import UIKit


class Launcher {
    
    static func launch(with window: UIWindow?) {
        if let nc = window?.rootViewController as? UINavigationController,
            let authorizationVC = nc.viewControllers.first as? AuthorizationViewController {
            let viewModel = AuthorizationViewModel()
            authorizationVC.viewModel = viewModel
            authorizationVC.router = AuthorizationRouter()
        }
    }
}
