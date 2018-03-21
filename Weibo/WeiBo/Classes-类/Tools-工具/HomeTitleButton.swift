//
//  TitleButton.swift
//  WeiBo
//
//  Created by 杨春贵 on 2017/10/13.
//  Copyright © 2017年 杨春贵. All rights reserved.
//

import UIKit

class HomeTitleButton: UIButton {
    // MARK: -重写init()函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "navBarItem_向下箭头"), for: .normal)
        setImage(UIImage(named: "navBarItem_向上箭头"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        sizeToFit()
    }
    
    //swift规定，重写控件的init()或init(frame)方法，必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 3
    }

}
