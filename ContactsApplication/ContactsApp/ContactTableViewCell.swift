//
//  ContactTableViewCell.swift
//  ContactsApp
//
//  Created by Macbook Air on 7.02.2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
