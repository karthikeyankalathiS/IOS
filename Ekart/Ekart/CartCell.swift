//
//  CartCell.swift
//  Ekart
//
//  Created by karthik on 15/02/24.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet var Title: UILabel!
    @IBOutlet var Img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
