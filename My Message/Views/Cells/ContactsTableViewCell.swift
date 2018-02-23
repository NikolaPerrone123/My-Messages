//
//  ContactsTableViewCell.swift
//  My Message
//
//  Created by Nikola Popovic on 2/23/18.
//  Copyright © 2018 Nikola Popovic. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
