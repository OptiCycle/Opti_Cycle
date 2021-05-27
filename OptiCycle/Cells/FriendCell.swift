//
//  FriendCell.swift
//  OptiCycle
//
//  Created by Max Skeen on 5/17/21.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
