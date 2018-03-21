//
//  MessageTableViewCell2.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/26.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class MessageTableViewCell2: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var sreenNameLabel: UILabel!
    
    @IBOutlet weak var msgContentLabel: UILabel!
    
    @IBOutlet weak var msgTimeLabel: UILabel!
    @IBOutlet weak var msgNumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
