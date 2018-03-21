//
//  ProfileTableViewCell.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/23.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
