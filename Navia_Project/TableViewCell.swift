//
//  TableViewCell.swift
//  Navia_Project
//
//  Created by Arinjay on 26/07/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var notificationTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
