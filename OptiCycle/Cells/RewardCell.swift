//
//  RewardCell.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 9/6/21.
//

import UIKit

class RewardCell: UITableViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rewardImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
