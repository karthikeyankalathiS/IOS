//
//  MainDetails.swift
//  Ekart
//
//  Created by karthik on 14/02/24.
//

import UIKit

class MainDetails: UITableViewCell {

    @IBOutlet var Title: UILabel!
    @IBOutlet var Img: UIImageView!
    @IBOutlet var Price: UILabel!
    
    @IBAction func Add(_ sender: Any) {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window,
            let rootViewController = window.rootViewController as? UITabBarController {

            let tabBar = rootViewController.tabBar

            if let cartItem = tabBar.items?[0] {
                if let currentBadgeValue = cartItem.badgeValue,
                   let currentBadgeInt = Int(currentBadgeValue) {
                    cartItem.badgeValue = "\(currentBadgeInt + 1)"
                } else {
                    cartItem.badgeValue = "1"
                }
            }
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
