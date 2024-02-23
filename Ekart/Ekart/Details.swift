//
//  Details.swift
//  Ekart
//
//  Created by karthik on 14/02/24.
//

import UIKit

class Details: UITableViewCell {

    @IBOutlet var Category: UILabel!
    @IBOutlet var Description: UITextView!
    @IBOutlet var Rating: UIStackView!
    
    func configureRatingStack(with rating: Product.Rating) {
        for subview in Rating.subviews {
            subview.removeFromSuperview()
        }

        for _ in 0..<Int(rating.rate) {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = UIColor.systemYellow
            Rating.addArrangedSubview(starImageView)
        }

        for _ in Int(rating.rate)..<5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star"))
            starImageView.tintColor = UIColor.systemYellow
            Rating.addArrangedSubview(starImageView)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

