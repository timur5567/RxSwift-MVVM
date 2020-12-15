//
//  UserTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by msoft on 10.12.2020.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var identyfierLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
