//
//  OnboardingViewController.swift
//  RxSwift+MVVM
//
//  Created by msoft on 23.11.2020.
//

import UIKit
import Swinject
import RxCocoa
import RxSwift

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var service: Service?
    private let disposeBag = DisposeBag()
    
    var viewModel: OnboardingViewModel?
    var router: OnboardingRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupService()
        registerCells()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell1")
        tableView.register(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell3")
    }
    
    private func setupService() {
        service = Container.sharedContainer.resolve(Services.self)?.userDefaults
    }
}

extension OnboardingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? UserInfoTableViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? ButtonsTableViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath) as? TextTableViewCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as? UserInfoTableViewCell
        }
        return cell
    }

}
