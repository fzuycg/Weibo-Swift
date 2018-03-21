//
//  UIBarButtonItem-Extension.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/13.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String) {
        self.init()
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.customView = btn
    }
    
    /*
     //另一种添加方法
    convenience init(imageName: String) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName+"_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
    */
}
