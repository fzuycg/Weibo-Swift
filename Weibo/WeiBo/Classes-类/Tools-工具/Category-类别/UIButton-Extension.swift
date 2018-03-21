//
//  UIButton-Extension.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/11.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

extension UIButton {
    // 在swift中类方法是以class开头的方法，类似于OC中+开头的方法
    /*
    class func creatButton(imageName: String, bgImageName: String) -> UIButton {
        //1.创建button
        let btn = UIButton()
        
        //2、设置button属性
        btn.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        return btn
    }
     */
    
    // MARK:- 构造函数实现
    //构造函数都是init，没有返回值
    //convenience:便利，使用convenience修饰的叫做便利构造函数
    //遍历构造函数是对系统的类进行扩充
    /*
     遍历构造函数的特点
         1、遍历构造函数通常写在extension里面
         2、遍历构造函数init前面需要加上convenience
         3、在遍历构造函数中要明确调用self.init()
     */
    convenience init (imageName: String, bgImageName: String) {
        self.init()
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
}
