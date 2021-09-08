//
//  HomeCell.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 9/4/21.
//

import UIKit
import MBCircularProgressBar

class HomeCell: UITableViewCell {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var numItemsLabel: UILabel!
    @IBOutlet weak var rewardsButton: UIButton!
    @IBOutlet weak var circleBar: MBCircularProgressBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
