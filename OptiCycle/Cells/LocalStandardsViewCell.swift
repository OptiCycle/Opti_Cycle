//
//  LocalStandardsViewCell.swift
//  OptiCycle
//
//  Created by Patrick Elisii on 4/10/21.
//

import UIKit

class LocalStandardsViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
