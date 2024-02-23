//
//  Products.swift
//  Ekart
//
//  Created by karthik on 14/02/24.
//

import UIKit

class Products: UITableViewCell {

    @IBOutlet var ProductImg: UIImageView!
    @IBOutlet var ProductTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductImg.layer.cornerRadius = ProductImg.frame.width / 2
        ProductImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}
