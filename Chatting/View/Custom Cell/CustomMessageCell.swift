//
//  CustomMessageCell.swift
//  Chatting
//
//  Created by Ahmed barghash on 3/2/20.
//  Copyright © 2020 Ahmed barghash. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var senderNameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
