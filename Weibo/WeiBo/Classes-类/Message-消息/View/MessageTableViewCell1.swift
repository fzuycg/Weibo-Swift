//
//  MessageTableViewCell1.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/26.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class MessageTableViewCell1: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var sreenNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
