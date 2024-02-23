//
//  TableViewCell.swift
//  NotificationVC
//
//  Created by karthik on 08/02/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var NameLbl: UILabel!
    @IBOutlet var MsgLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
