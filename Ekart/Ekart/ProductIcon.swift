//
//  ProductIcon.swift
//  Ekart
//
//  Created by karthik on 15/02/24.
//

import UIKit

class ProductIcon: UICollectionViewCell {

    @IBOutlet var Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Img.layer.cornerRadius = Img.frame.width / 4
        Img.clipsToBounds = true
    }

}
