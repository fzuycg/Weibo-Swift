//
//  FriendsListTableViewCell.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/12/4.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class FriendsListTableViewCell: UITableViewCell {
    // MARK: -控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var verifiedReasonLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    //MARK:- 定义属性
    var model: UserModel? {
        didSet {
            guard let model = model else {
                return
            }
            
            //1、设置头像
            guard let urlString = model.profile_image_url else {
                return
            }
            guard let url = URL(string: urlString) else {
                return
            }
            iconImageView.setImageWith(url, placeholderImage: UIImage(named: "welcome_userIcon"))
            
            //2、设置昵称
            screenNameLabel.text = model.screen_name ?? ""
            
            //3、设置认证描述
            verifiedReasonLabel.text = model.verified_reason ?? ""
            
            //4、设置自我描述
            descriptionLabel.text = model.description1 ?? ""
        }
    }
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.borderColor = UIColor.orange.cgColor;
        followButton.layer.borderWidth = 1;
        followButton.layer.cornerRadius = 2;
    }
}
