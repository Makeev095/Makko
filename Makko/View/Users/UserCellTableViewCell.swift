//
//  UserCellTableViewCell.swift
//  Makko
//
//  Created by Макей 😈 on 08.01.2024.
//

import UIKit

class UserCellTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    static let reuseId = "UserCellTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingCell()
    }

    func configCell(_ name: String) {
        userName.text = name
    }
    
    func settingCell() {
        parentView.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
