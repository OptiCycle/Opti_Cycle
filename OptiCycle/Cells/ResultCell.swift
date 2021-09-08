//
//  ResultCell.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 9/6/21.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
