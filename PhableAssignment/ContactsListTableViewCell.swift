//
//  ContactsListTableViewCell.swift
//  PhableAssignment
//
//  Created by Usha Annadanapu on 10/06/20.
//  Copyright © 2020 Usha Annadanapu. All rights reserved.
//

import UIKit

class ContactsListTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    static var identifier: String {
        return String(describing: self)
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
