//
//  VisitorView.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/13.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    // MARK:- 链接属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    /// 设置访客视图页面的信息
    func setupVisitorViewInfo(imageName: String, tipText: String) {
        iconImageView.image = UIImage(named:imageName)
        tipLabel.text = tipText
    }

}
