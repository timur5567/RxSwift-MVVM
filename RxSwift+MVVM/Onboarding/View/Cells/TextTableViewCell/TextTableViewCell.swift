//
//  TextTableViewCell.swift
//  RxSwift+MVVM
//
//  Created by msoft on 10.12.2020.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        // Initialization code
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
