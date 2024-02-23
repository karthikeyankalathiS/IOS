//
//  DetailsCell.swift
//  ApiVC
//
//  Created by karthik on 08/02/24.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var txtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
